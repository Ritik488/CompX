import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(-1.0, 0.0), end: Offset.zero)
                  .animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          }));
}

void changeScreenRepacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
