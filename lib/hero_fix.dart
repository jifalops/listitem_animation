import 'package:flutter/material.dart';

/// Fixes a [Hero] of [Text] by making sure inherited styles are available
/// during the hero transition. May fix other inherited widget bugs with hero.
///
/// See https://github.com/flutter/flutter/issues/12463#issuecomment-387505006.
class HeroFix1 extends StatelessWidget {
  HeroFix1({@required this.tag, @required this.text, this.style});
  final String tag;
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: Text(text, style: style ?? DefaultTextStyle.of(context).style),
      ),
    );
  }
}

class HeroFix2 extends StatelessWidget {
  HeroFix2({@required this.tag, @required this.text, this.style});
  final String tag;
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: style ?? DefaultTextStyle.of(context).style,
      child: Hero(
        flightShuttleBuilder: (_,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext) {
          return AnimatedBuilder(
            animation: animation,
            child: Text(text),
            builder: (_, _child) {
              return DefaultTextStyle.merge(
                child: _child,
                style: TextStyle.lerp(
                    DefaultTextStyle.of(fromHeroContext).style,
                    DefaultTextStyle.of(toHeroContext).style,
                    flightDirection == HeroFlightDirection.pop
                        ? 1 - animation.value
                        : animation.value),
              );
            },
          );
        },
        tag: tag,
        child: Text(text),
      ),
    );
  }
}
