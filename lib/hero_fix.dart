import 'package:flutter/material.dart';

/// Fixes a [Hero] of [Text] by making sure inherited styles are available
/// during the hero transition. May fix other inherited widget bugs with hero.
///
/// See https://github.com/flutter/flutter/issues/12463#issuecomment-387505006.
class HeroFix extends StatelessWidget {
  HeroFix({@required this.tag, @required this.child});
  final String tag;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
