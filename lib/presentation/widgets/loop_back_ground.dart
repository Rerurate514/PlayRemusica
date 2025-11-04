import 'package:flutter/material.dart';

class LoopBackGround extends StatelessWidget {
  final Animation<Offset> gradationAnimation;
  final AnimationController animationController;
  final Widget? child;
  final double? fullWidth;
  final bool isAnimation;
  final Offset? initialOffset;

  const LoopBackGround({
    super.key, 
    required this.gradationAnimation,
    required this.animationController,
    this.child,
    this.fullWidth,
    this.isAnimation = true,
    this.initialOffset,
  });

  final gradateBeginColor = const Color.fromARGB(255, 220, 40, 110);
  final gradateEndColor = const Color.fromARGB(255, 0, 133, 255);

  @override
  Widget build(BuildContext context) {
    final backgroundBoxDecoration = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        gradateBeginColor,
        gradateEndColor,
        gradateBeginColor,
        gradateEndColor,
        gradateBeginColor,
      ],
      stops: const [
        0.0,
        0.25,
        0.5,
        0.75,
        1.0,
      ],
    );

    return AnimatedBuilder(
      animation: animationController,
      child: child,
      builder: (BuildContext context, child) {
        return Stack(
          children: [
            Positioned(
              child: Transform.translate(
                offset: isAnimation
                    ? gradationAnimation.value + (initialOffset ?? Offset.zero)
                    : initialOffset ?? Offset.zero,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  child: SizedBox(
                    width: fullWidth ?? MediaQuery.of(context).size.width * 5,
                    height: MediaQuery.of(context).size.height,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: backgroundBoxDecoration,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (child != null)
              Positioned(
                child: child,
              ),
          ],
        );
      },
    );
  }
}
