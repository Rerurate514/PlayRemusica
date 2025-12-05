import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/core/settings/my_colors.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/features/player/presentation/viewmodel/volume_slider_view_model.dart';
import 'package:playremusica/presentation/shapes/custom_slider_shape.dart';
import 'package:playremusica/presentation/widgets/glass_filter_card.dart';
import 'package:playremusica/presentation/widgets/gradient_icon.dart';

class VolumeController extends HookConsumerWidget {
  const VolumeController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final volumeSliderViewModel = ref.read(
      volumeSliderViewModelProvider.notifier,
    );

    Widget buildSlider() {
      final playPageViewModel = ref.read(playPageViewModelProvider.notifier);
      final volume = useState(playPageViewModel.getVolume());

      return Column(
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: CustomSliderShape(
                  thumbRadius: 15.0,
                  thumbWidth: 40.0,
                  label: (volume.value * 100).toInt().toString(),
                ),
              ),
              child: Slider(
                min: 0.0,
                max: 1.0,
                value: volume.value,
                onChanged: (value) {
                  volume.value = value;
                  playPageViewModel.setVolume(value);
                },
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            volumeSliderViewModel.switchVolumeSlider();
          },
          child: Container(color: Colors.transparent),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(86),
            child: SizedBox(
              height: 350,
              width: 100,
              child: GlassFilterCard(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      buildSlider(),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GradientIcon(
                            icon: Icons.volume_up,
                            size: 32,
                            gradient: MyColors.iconGradient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
