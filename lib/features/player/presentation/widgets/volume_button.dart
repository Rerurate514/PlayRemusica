import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/volume_slider_view_model.dart'; 
import 'package:playremusica/presentation/widgets/glass_filter_card.dart';
import 'package:playremusica/presentation/widgets/ink_card.dart';

class VolumeButton extends HookConsumerWidget {
  const VolumeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.read(volumeSliderViewModelProvider.notifier);

    return InkCard(
      radius: 256,
      onTap: () {
        prov.switchVolumeSlider();
      },
      child: const GlassFilterCard(
        radius: 256,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.volume_up),
        ),
      ),
    );
  }
}
