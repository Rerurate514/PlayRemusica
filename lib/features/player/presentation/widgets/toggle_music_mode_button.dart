import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/domain/values/music_mode.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/presentation/widgets/glass_filter_card.dart';
import 'package:playremusica/presentation/widgets/ink_card.dart';

class ToggleMusicModeButton extends ConsumerStatefulWidget {
  const ToggleMusicModeButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToggleMusicModeButtonState();
}
class _ToggleMusicModeButtonState extends ConsumerState<ToggleMusicModeButton> {
    @override
  Widget build(BuildContext context) {
    final prov = ref.watch(playPageViewModelProvider.notifier);
    final musicMode = ref.watch(playPageViewModelProvider.select((state) {
      return state.currentMusicMode;
    }));
    
    return InkCard(
      radius: 256,
      onTap: () {
        prov.toggleMusicMode();
      }, 
      child: GlassFilterCard(
        radius: 256,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: switch(musicMode){
            Normal() => Icon(Icons.arrow_right_alt),
            Loop() => Icon(Icons.loop),
            Shuffle() => Icon(Icons.shuffle),
          }
        ),
      ),
    );
  }
}
