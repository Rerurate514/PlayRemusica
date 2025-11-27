import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';

class MusicSlider extends HookConsumerWidget {
  const MusicSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playPageViewModelProvider);
    final prov = ref.read(playPageViewModelProvider.notifier);

    final current = state.value?.currentSeconds ?? 0.0;
    final duration = prov.getDurationSeconds();

    return Slider(
      min: 0.0,
      max: duration,
      value: current,
      onChanged: (currentValue) {
        prov.seek(currentValue);
      }
    );
  }
}
