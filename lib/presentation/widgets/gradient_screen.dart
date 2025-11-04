import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:playremusica/presentation/widgets/loop_back_ground.dart';

class GradientScreen extends HookWidget {
  const GradientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: const Duration(seconds: 25));
    final startOffset = MediaQuery.of(context).size.width * -3;
    final endOffset = MediaQuery.of(context).size.width * -0.5;
    final tween = Tween<Offset>(begin: Offset(startOffset, 0), end: Offset(endOffset, 0));
    final gradationAnimation = tween.animate(animationController);
    const zeroOffset = Offset.zero;
    final twoFive = MediaQuery.of(context).size.width * 0.25;
    final slowTween = Tween<Offset>(begin: zeroOffset, end: Offset(twoFive, 0));
    slowTween.animate(animationController);

    useEffect(() {
      animationController.repeat();
      return () {};
    }, []);

    return LoopBackGround(
      gradationAnimation: gradationAnimation,
      animationController: animationController,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
      ),
    );
  }
}
