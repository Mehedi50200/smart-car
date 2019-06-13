library flutter_duration_picker;

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
int tempInC;

const Duration _kDialAnimateDuration = const Duration(milliseconds: 200);

const double _kDurationPickerWidthPortrait = 328.0 ;
const double _kDurationPickerWidthLandscape = 512.0;

const double _kDurationPickerHeightPortrait = 380.0;
const double _kDurationPickerHeightLandscape = 304.0;

const double _kTwoPi = 2 * math.pi;
const double _kPiByTwo = math.pi / 2;

const double _kCircleTop = _kPiByTwo;


class _DialPainter extends CustomPainter {
  const _DialPainter({
    @required this.context,
    @required this.backgroundColor,
    @required this.accentColor,
    @required this.theta,
    @required this.textDirection,
    @required this.selectedValue,
    @required this.pct,
    @required this.multiplier,
  });

  final Color backgroundColor;
  final Color accentColor;
  final double theta;
  final TextDirection textDirection;
  final int selectedValue;
  final BuildContext context;

  final double pct;
  final int multiplier;

  @override
  void paint(Canvas canvas, Size size) {
    const double _epsilon = .001;
    const double _sweep = _kTwoPi - _epsilon;
    const double _startAngle = -math.pi / 2.0;

    final double radius = size.shortestSide / 2.2;
    final Offset center = new Offset(size.width / 2.0, size.height / 2.0);
    final Offset centerPoint = center;

    double pctTheta = (0.25 - (theta % _kTwoPi) / _kTwoPi) % 1.0;

    // Get the offset point for an angle value of theta, and a distance of _radius
    Offset getOffsetForTheta(double theta, double _radius) {
      return center +
          new Offset(_radius * math.cos(theta), -_radius * math.sin(theta));
    }

    tempInC = (pctTheta * 50).round();
    tempInC = tempInC == 50 ? 0 : tempInC;
    TextPainter textDurationValuePainter = new TextPainter(
        textAlign: TextAlign.center,
        text: new TextSpan(
            text: '${tempInC > 0 ? tempInC : "0"}',
            style: TextStyle(color: Colors.grey[50], fontSize: 20)
                .copyWith(fontSize: size.shortestSide * 0.25)),
        textDirection: TextDirection.ltr)
      ..layout();
    Offset middleForValueText = new Offset(
        centerPoint.dx - (textDurationValuePainter.width / 2),
        centerPoint.dy - textDurationValuePainter.height / 2);
    textDurationValuePainter.paint(canvas, middleForValueText);

    TextPainter textMinPainter = new TextPainter(
        textAlign: TextAlign.center,
        text: new TextSpan(
            text: '° C', //th: ${theta}',
            style: TextStyle(color: Colors.grey[600], fontSize: 22)),
        textDirection: TextDirection.ltr)
      ..layout();
    textMinPainter.paint(
        canvas,
        new Offset(centerPoint.dx + textDurationValuePainter.width * 0.6,
            centerPoint.dy));

    // Draw an arc around the circle for the amount of the circle that has elapsed.
    var elapsedPainter = new Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white
      ..isAntiAlias = true
      ..strokeWidth = radius * 0.05;

    final Gradient gradient = new RadialGradient(
      colors: <Color>[
        Colors.blue.withOpacity(0.9),
        Colors.green.withOpacity(0.6),
        Colors.yellow.withOpacity(0.6),
        Colors.orange.withOpacity(0.6),
        Colors.red.withOpacity(0.8),
      ],
    );

    Rect rect = new Rect.fromCircle(
      center: new Offset(165.0, 55.0),
      radius: 150.0,
    );

    var circlepainterPainter = new Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect)
      ..isAntiAlias = true
      ..strokeWidth = radius * 0.05;

    canvas.drawArc(
      new Rect.fromCircle(
        center: centerPoint,
        radius: radius - radius * 0.12 / 2,
      ),
      _startAngle,
      _sweep * pctTheta,
      false,
      elapsedPainter,
    );

    canvas.drawArc(
      new Rect.fromCircle(
        center: centerPoint,
        radius: radius - radius * 0.12 / 2,
      ),
      180,
      100,
      false,
      circlepainterPainter,
    );

    getHandleColor(int svalue) {
      print(svalue);
      if (svalue == 6 || svalue == 3) {
        return Colors.yellow;
      } else if (svalue == 2 || svalue == 0) {
        return Colors.green;
      } else if (svalue == 1) {
        return Colors.blue;
      } else
        return Colors.red;
    }

    // Draw the handle that is used to drag and to indicate the position around the circle

    final Paint handlePaint = new Paint()
      ..color = getHandleColor(theta.round());
    final Offset handlePoint = getOffsetForTheta(theta, radius - 7);
    canvas.drawCircle(handlePoint, 10.0, handlePaint);
  }

  @override
  bool shouldRepaint(_DialPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.accentColor != accentColor ||
        oldPainter.theta != theta;
  }
}

class _Dial extends StatefulWidget {
  const _Dial({
    @required this.temparature,
    @required this.onChanged,
  }) : assert(temparature != null);

  final int temparature;
  final ValueChanged<int> onChanged;

  @override
  _DialState createState() => new _DialState();
}

class _DialState extends State<_Dial> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _thetaController = new AnimationController(
      duration: _kDialAnimateDuration,
      vsync: this,
    );
    _thetaTween =
        new Tween<double>(begin: _getThetaForDuration(widget.temparature));
    _theta = _thetaTween.animate(new CurvedAnimation(
        parent: _thetaController, curve: Curves.fastOutSlowIn))
      ..addListener(() => setState(() {}));

    _tempInC = widget.temparature;
  }

  ThemeData themeData;
  MaterialLocalizations localizations;
  MediaQueryData media;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMediaQuery(context));
    themeData = Theme.of(context);
    localizations = MaterialLocalizations.of(context);
    media = MediaQuery.of(context);
  }

  @override
  void dispose() {
    _thetaController.dispose();
    super.dispose();
  }

  Tween<double> _thetaTween;
  Animation<double> _theta;
  AnimationController _thetaController;

  double _pct = 0.0;
  int _tempInC = 0;
  bool _dragging = false;

  double _getThetaForDuration(temparature) {
    final double fractionalRotation = (temparature / 100);
    var theta = (_kPiByTwo - fractionalRotation * _kTwoPi) % _kTwoPi;
    return theta;
  }


  int _notifyOnChangedIfNeeded() {
    var d = _tempInC;
    widget.onChanged(d);

    return d;
  }

  void _updateThetaForPan() {
    setState(() {
      final Offset offset = _position - _center;
      final double angle =
          (math.atan2(offset.dx, offset.dy) - _kPiByTwo) % _kTwoPi;

      // Stop accidental abrupt pans from making the dial seem like it starts from 1h.
      // (happens when wanting to pan from 0 clockwise, but when doing so quickly, one actually pans from before 0 (e.g. setting the duration to 59mins, and then crossing 0, which would then mean 1h 1min).
      if (angle >= _kCircleTop &&
          _theta.value <= _kCircleTop &&
          _theta.value >= 0.1 && // to allow the radians sign change at 15mins.
          _tempInC == 0) return;

      _thetaTween
        ..begin = angle
        ..end = angle;
    });
  }

  Offset _position;
  Offset _center;

  void _handlePanStart(DragStartDetails details) {
    assert(!_dragging);
    _dragging = true;
    final RenderBox box = context.findRenderObject();
    _position = box.globalToLocal(details.globalPosition);
    _center = box.size.center(Offset.zero);

    _updateThetaForPan();
    _notifyOnChangedIfNeeded();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    double oldTheta = _theta.value;
    _position += details.delta;
    _updateThetaForPan();
    double newTheta = _theta.value;

    _updateRotations(oldTheta, newTheta);

    _notifyOnChangedIfNeeded();
  }

  void _updateRotations(double oldTheta, double newTheta) {
     setState(() => _tempInC = tempInC);
    // If the angle crosses clockwise through 12'o'clock
    // if (oldTheta > _kCircleTop &&
    //     newTheta <= _kCircleTop &&
    //     oldTheta < _kCircleLeft) {
    //   setState(() => _tempInC = _tempInC + 1);
    //   // If the angle cross anti-clockwise through 12'o'clock
    // } else if (oldTheta <= _kCircleTop &&
    //     newTheta > _kCircleTop &&
    //     newTheta < _kCircleBottom) {
    //   if (_tempInC > 0) {
    //     setState(() => _tempInC = _tempInC - 1);
    //   }
    // }
  }

  void _handlePanEnd(DragEndDetails details) {
    assert(_dragging);
    _dragging = false;
    _position = null;
    _center = null;
    //_notifyOnChangedIfNeeded();
  }

  void _handleTapUp(TapUpDetails details) {
    final RenderBox box = context.findRenderObject();
    _position = box.globalToLocal(details.globalPosition);
    _center = box.size.center(Offset.zero);
    _updateThetaForPan();
    _notifyOnChangedIfNeeded();

    _dragging = false;
    _position = null;
    _center = null;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (themeData.brightness) {
      case Brightness.light:
        backgroundColor = Colors.grey[200]; //bar color
        break;
      case Brightness.dark:
        backgroundColor = Color(0x00000000);
        break;
    }

    int selectedDialValue;

    return new GestureDetector(
        excludeFromSemantics: true,
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        onTapUp: _handleTapUp,
        child: new CustomPaint(
          painter: new _DialPainter(
            pct: _pct,
            multiplier: _tempInC,
            context: context,
            selectedValue: selectedDialValue,
            backgroundColor: backgroundColor,
            accentColor: themeData.accentColor,
            theta: _theta.value,
            textDirection: Directionality.of(context),
          ),
        ));
  }
}

/// A duration picker designed to appear inside a popup dialog.
///
/// Pass this widget to [showDialog]. The value returned by [showDialog] is the
/// selected [Duration] if the user taps the "OK" button, or null if the user
/// taps the "CANCEL" button. The selected time is reported by calling
/// [Navigator.pop].
class _DurationPickerDialog extends StatefulWidget {
  /// Creates a duration picker.
  ///
  /// [initialTime] must not be null.
  const _DurationPickerDialog(
      {Key key, @required this.initialTemparature, this.snapToMins})
      : assert(initialTemparature != null),
        super(key: key);

  /// The duration initially selected when the dialog is shown.
  final int initialTemparature;
  final double snapToMins;

  @override
  _DurationPickerDialogState createState() => new _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<_DurationPickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedTemparature = widget.initialTemparature;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
  }

  int get selectedDuration => _selectedTemparature;
  int _selectedTemparature;

  MaterialLocalizations localizations;

  void _handleTimeChanged(int value) {
    setState(() {
      _selectedTemparature = value;
    });
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleOk() {
    Navigator.pop(context, _selectedTemparature);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final ThemeData theme = Theme.of(context);

    final Widget picker = new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new AspectRatio(
            aspectRatio: 1.0,
            child: new _Dial(
              temparature: _selectedTemparature,
              onChanged: _handleTimeChanged,
            )));

    final Widget actions = new ButtonTheme.bar(
        child: new ButtonBar(children: <Widget>[
      new FlatButton(
          child: new Text(localizations.cancelButtonLabel),
          onPressed: _handleCancel),
      new FlatButton(
          child: new Text(localizations.okButtonLabel), onPressed: _handleOk),
    ]));

    final Dialog dialog = new Dialog(child: new OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      final Widget pickerAndActions = new Container(
        color: theme.dialogBackgroundColor,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Expanded(
                child:
                    picker), // picker grows and shrinks with the available space
            actions,
          ],
        ),
      );

      assert(orientation != null);
      switch (orientation) {
        case Orientation.portrait:
          return new SizedBox(
              width: _kDurationPickerWidthPortrait,
              height: _kDurationPickerHeightPortrait,
              child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Expanded(
                      child: pickerAndActions,
                    ),
                  ]));
        case Orientation.landscape:
          return new SizedBox(
              width: _kDurationPickerWidthLandscape,
              height: _kDurationPickerHeightLandscape,
              child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Flexible(
                      child: pickerAndActions,
                    ),
                  ]));
      }
      return null;
    }));

    return new Theme(
      data: theme.copyWith(
        dialogBackgroundColor: Colors.transparent,
      ),
      child: dialog,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Shows a dialog containing the duration picker.
///
/// The returned Future resolves to the duration selected by the user when the user
/// closes the dialog. If the user cancels the dialog, null is returned.
///
/// To show a dialog with [initialTime] equal to the current time:
///
/// ```dart
/// showDurationPicker(
///   initialTime: new Duration.now(),
///   context: context,
/// );
/// ```
Future<int> showDurationPicker(
    {@required BuildContext context,
    @required int initialTemparature,
    double snapToMins}) async {
  assert(context != null);
  assert(initialTemparature != null);

  return await showDialog<int>(
    context: context,
    builder: (BuildContext context) =>
        new _DurationPickerDialog(initialTemparature: initialTemparature),
  );
}

class DurationPicker extends StatelessWidget {
  final int temparature;
  final ValueChanged<int> onChange;
  final double snapToMins;

  final double width;
  final double height;

  DurationPicker(
      {this.temparature = 0,
      @required this.onChange,
      this.snapToMins,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? _kDurationPickerWidthPortrait / 1.5,
        height: height ?? _kDurationPickerHeightPortrait / 1.5,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _Dial(
                  temparature: temparature,
                  onChanged: onChange,
                ),
              ),
            ]));
  }
}
