import 'package:flutter/material.dart';

Future pageRoute(
    {required BuildContext context, required Widget route, required bool back}) {
  return Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          return route;
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.linear, parent: animation);
          return _pageRouteBuilderAnimation(animation, child);
        },
      ),
      (route) => back);
}

Align _pageRouteBuilderAnimation(Animation<double> animation, Widget child) {
  return Align(
    child: SlideTransition(
      position: Tween(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    ),
  );
}
