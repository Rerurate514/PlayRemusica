import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/application/notifiers/music_player_notifier.dart';

class MusicSlider extends HookConsumerWidget {
  const MusicSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(musicPlayerProvider);
    final musicCurrent = useState(0.0);

    return Slider(
      value: musicCurrent.value, 
      onChanged: (currentValue) {
        musicCurrent.value = currentValue;
      }
    );
  }
}
