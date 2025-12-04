import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/presentation/widgets/glass_filter_card.dart';
import 'package:playremusica/presentation/widgets/ink_card.dart';

class PlayButton extends HookConsumerWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(playPageViewModelProvider.notifier);
    final isPlaying = ref.watch(playPageViewModelProvider.select(
      (state) => state.value?.isPlaying ?? false,
    ));
    
    return InkCard(
      radius: 256,
      onTap: () {
        if(isPlaying) {
          prov.pause();
        } else {
          prov.resume();
        }
      }, 
      child: GlassFilterCard(
        radius: 256,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Icon(
            isPlaying
            ? Icons.pause
            : Icons.play_arrow,
            size: 45,
          ),
        ),
      ),
    );
  }
}
