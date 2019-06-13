import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

enum SwipePosition {
  SwipeLeft,
  SwipeRight,
}

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    Key key,
    this.bg,
    this.thumb,
    this.content,
    BorderRadius borderRadius,
    this.initialPosition = SwipePosition.SwipeLeft,
    @required this.onChanged,
    this.height = 60.0,
  })  : assert(initialPosition != null && onChanged != null && height != null),
        this.borderRadius = borderRadius ?? BorderRadius.zero,
        super(key: key);
  final bool bg;
  final Widget thumb;
  final Widget content;
  final BorderRadius borderRadius;
  final double height;
  final SwipePosition initialPosition;
  final ValueChanged<SwipePosition> onChanged;

  @override
  SwipeButtonState createState() => SwipeButtonState();
}

class SwipeButtonState extends State<SwipeButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();

  AnimationController _controller;
 // Animation<double> _contentAnimation;
  Offset _start = Offset.zero;

  RenderBox get _positioned => _positionedKey.currentContext.findRenderObject();

  RenderBox get _container => _containerKey.currentContext.findRenderObject();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
    // _contentAnimation = Tween<double>(begin: 1.0, end: 0.0)
    //     .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.initialPosition == SwipePosition.SwipeRight) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100, // widget.height,
      child: Stack(
        alignment: Alignment.center,
        key: _containerKey,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: MySeparator(color: Colors.grey[800]),
          ),
          Container(
            margin: EdgeInsets.only(top: 35),
            child: widget.content,
          ),
          Align(
            alignment: widget.bg ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[800])
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/car_control/swipe_gif.gif"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 60,
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Image(
                height: 20,
                width: 20,
                image: AssetImage("assets/car_control/lock.png"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 60,
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Image(
                height: 20,
                width: 20,
                image: AssetImage("assets/car_control/unlock.png"),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Align(
                alignment: Alignment((_controller.value * 2.0) - 1.0, 0.0),
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10), child: child),
              );
            },
            child: GestureDetector(
              onHorizontalDragStart: _onDragStart,
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: Container(
                key: _positionedKey,
                width: widget.height,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                ),
                child: widget.thumb,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    final pos = _positioned.globalToLocal(details.globalPosition);
    _start = Offset(pos.dx, 0.0);
    _controller.stop(canceled: true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final pos = _container.globalToLocal(details.globalPosition) - _start;
    final extent = _container.size.width - _positioned.size.width;
    _controller.value = (pos.dx.clamp(0.0, extent) / extent);
  }

  void _onDragEnd(DragEndDetails details) {
    final extent = _container.size.width - _positioned.size.width;
    var fractionalVelocity = (details.primaryVelocity / extent).abs();
    if (fractionalVelocity < 0.5) {
      fractionalVelocity = 0.5;
    }
    SwipePosition result;
    double acceleration, velocity;
    if (_controller.value > 0.5) {
      acceleration = 0.5;
      velocity = fractionalVelocity;
      result = SwipePosition.SwipeRight;
    } else {
      acceleration = -0.5;
      velocity = -fractionalVelocity;
      result = SwipePosition.SwipeLeft;
    }
    final simulation = _SwipeSimulation(
      acceleration,
      _controller.value,
      1.0,
      velocity,
    );
    _controller.animateWith(simulation).then((_) {
      if (widget.onChanged != null) {
        widget.onChanged(result);
      }
    });
  }
}

class _SwipeSimulation extends GravitySimulation {
  _SwipeSimulation(
      double acceleration, double distance, double endDistance, double velocity)
      : super(acceleration, distance, endDistance, velocity);

  @override
  double x(double time) => super.x(time).clamp(0.0, 1.0);

  @override
  bool isDone(double time) {
    final _x = x(time).abs();
    return _x <= 0.0 || _x >= 1.0;
  }
}


class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
