import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/volume_slider_view_model.dart';
import 'package:playremusica/features/player/presentation/widgets/volume_controller.dart';

class VolumeSwitcher extends ConsumerStatefulWidget {
  const VolumeSwitcher({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VolumeSwitcherState();
}

class _VolumeSwitcherState extends ConsumerState<VolumeSwitcher> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(volumeSliderViewModelProvider);
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero
          ).animate(animation),
          child: child,
        );
      },
      child: state.isShowVolumeSlider
      ? VolumeController()
      : const SizedBox.shrink(),
    );
  }
}
