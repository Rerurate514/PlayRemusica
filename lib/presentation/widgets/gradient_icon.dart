import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon({
    super.key, 
    required this.icon, 
    required this.size, 
    required this.gradient
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return gradient.createShader(rect);
      },
      blendMode: BlendMode.srcIn,
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
