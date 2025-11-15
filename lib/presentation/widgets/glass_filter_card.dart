import 'dart:ui';

import 'package:flutter/material.dart';

class GlassFilterCard extends StatelessWidget {
  final Widget child;
  final Function onTap;
  
  const GlassFilterCard({
    super.key,
    required this.child,
    this.onTap = _voidCallback
  });

  static void _voidCallback() {}

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),// ignore: deprecated_member_use
                  Colors.white.withOpacity(0.01),// ignore: deprecated_member_use
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: child
            ),
          ),
        ),
      )
    );
  }
}
