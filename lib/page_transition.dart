import 'package:flutter/cupertino.dart';

PageRouteBuilder fadeTransition({Widget child}) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final _opacity = animation.drive(Tween<double>(begin: 0, end: 1));

        return FadeTransition(opacity: _opacity, child: child);
      });
}

PageRouteBuilder slideTransition({Widget child}) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final _offset = animation
            .drive(Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)));

        return SlideTransition(position: _offset, child: child);
      });
}
