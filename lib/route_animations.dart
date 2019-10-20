import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FadePageRoute extends MaterialPageRoute {
  FadePageRoute({@required WidgetBuilder builder}) : super(builder: builder) {
    timeDilation = 1;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
