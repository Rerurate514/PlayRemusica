import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/domain/entities/time.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/presentation/shapes/custom_slider_shape.dart';

class MusicSlider extends HookConsumerWidget {
  const MusicSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playPageViewModelProvider);
    final prov = ref.read(playPageViewModelProvider.notifier);

    final isDragging = useState(false);
    final userDragValue = useState(Time.createEmpty());

    final current = state.currentSeconds;
    final duration = prov.getDurationSeconds();

    final displayValue = isDragging.value ? userDragValue.value : current;

    useEffect(() {
      if (isDragging.value &&
          current != Time.createEmpty() &&
          current == userDragValue.value) {
        isDragging.value = false;
      }
      return null;
    }, [current, isDragging.value]);

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: CustomSliderShape(
          thumbRadius: 15.0,
          thumbWidth: 60.0,
          label: displayValue.toString()
        ),
      ),
      child: Slider(
        min: 0.0,
        max: duration.rawSeconds,
        value: displayValue.rawSeconds,
        onChanged: (value) {
          userDragValue.value = Time(rawSeconds: value);
          isDragging.value = true;
        },
        onChangeEnd: (value) {
          prov.seek(value);
          userDragValue.value = Time(rawSeconds: value);
        },
      ),
    );
  }
}
