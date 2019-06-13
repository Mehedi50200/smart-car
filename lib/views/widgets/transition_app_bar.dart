import 'package:flutter/material.dart';

Size screenSize;

class TransitionAppBar extends StatelessWidget {
  final Widget nav;
  final Widget avatar;
  final Widget title;
  final Widget button;
  final Widget stats;

  const TransitionAppBar(
      {this.nav, this.avatar, this.title, this.button, this.stats, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
        nav: nav,
        avatar: avatar,
        title: title,
        button: button,
        stats: stats,
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _navTween = SizeTween(begin: Size(40.0, 40.0), end: Size(40.0, 40.0));
  final _navMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 10), end: EdgeInsets.only(left: 0));
  final _navAlignTween =
      AlignmentTween(begin: Alignment.topLeft, end: Alignment.centerLeft);

  final _avatarTween =
      SizeTween(begin: Size(130.0, 130.0), end: Size(50.0, 50.0));
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 10.0),
      end: EdgeInsets.only(left: 40.0 + 5.0));
  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.topCenter, end: Alignment.centerLeft);

  final _titleMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 5.0), end: EdgeInsets.only(left: 10.0));
  final _titleAlignTween =
      AlignmentTween(begin: Alignment.center, end: Alignment.center);

//  final _buttonTween =  SizeTween(begin: Size(140.0, 30.0), end: Size(100.0, 25.0));
  final _buttonMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 80), end: EdgeInsets.only(right: 10.0));
  final _buttonAlignTween =
      AlignmentTween(begin: Alignment.center, end: Alignment.centerRight);

  final _statsTween =
      SizeTween(begin: Size(screenSize.width, 55.0), end: Size(200, 55.0));
  final _statsMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      end: EdgeInsets.all(1));
  final _statsAlignTween =
      AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.topCenter);
  final _statsOpacityTween = Tween(begin: 1.0, end: 0.0);

  final Widget nav;
  final Widget avatar;
  final Widget title;
  final Widget button;
  final Widget stats;

  _TransitionAppBarDelegate(
      {this.nav, this.avatar, this.title, this.button, this.stats})
      : assert(nav != null),
        assert(avatar != null),
        assert(title != null),
        assert(button != null),
        assert(stats != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / 310.0;

    final navSize = _navTween.lerp(progress);
    final navMargin = _navMarginTween.lerp(progress);
    final navAlign = _navAlignTween.lerp(progress);

    final avatarSize = _avatarTween.lerp(progress);
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    final titleMargin = _titleMarginTween.lerp(progress);
    final titleAlign = _titleAlignTween.lerp(progress);

  //  final buttonSize = _buttonTween.lerp(progress);
    final buttonMargin = _buttonMarginTween.lerp(progress);
    final buttonAlign = _buttonAlignTween.lerp(progress);

    final statsSize = _statsTween.lerp(progress);
    final statsMargin = _statsMarginTween.lerp(progress);
    final statsAlign = _statsAlignTween.lerp(progress);
    final statsOpacity = _statsOpacityTween.transform(progress);

    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: navMargin,
            child: Align(
              alignment: navAlign,
              child: SizedBox.fromSize(size: navSize, child: nav),
            ),
          ),
          Padding(
            padding: avatarMargin,
            child: Align(
              alignment: avatarAlign,
              child: SizedBox.fromSize(size: avatarSize, child: avatar),
            ),
          ),
          Padding(
            padding: titleMargin,
            child: Align(
              alignment: titleAlign,
              child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.title, child: title),
            ),
          ),
          Padding(
            padding: buttonMargin,
            child: Align(
              alignment: buttonAlign,
              child: SizedBox.fromSize(child: button),
            ),
          ),
          Padding(
            padding: statsMargin,
            child: Align(
              alignment: statsAlign,
              child: Opacity(
                opacity: statsOpacity,
                child: SizedBox.fromSize(size: statsSize, child: stats),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 310.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return nav != oldDelegate.nav ||
        avatar != oldDelegate.avatar ||
        title != oldDelegate.title ||
        button != oldDelegate.button ||
        stats != oldDelegate.stats;
  }
}
