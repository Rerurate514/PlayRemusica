import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/features/player/presentation/widgets/move_next_button.dart';
import 'package:playremusica/features/player/presentation/widgets/move_previous_button.dart';
import 'package:playremusica/features/player/presentation/widgets/music_image.dart';
import 'package:playremusica/features/player/presentation/widgets/music_slider.dart';
import 'package:playremusica/features/player/presentation/widgets/play_button.dart';
import 'package:playremusica/features/player/presentation/widgets/toggle_music_mode_button.dart';
import 'package:playremusica/features/player/presentation/widgets/volume_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PlayPage extends HookConsumerWidget {
  const PlayPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(playPageViewModelProvider);
    final provValue = ref.watch(
      playPageViewModelProvider.select((asyncValue) {
        final state = asyncValue.value;
        if(state == null) return null;

        return (
          state.currentMusic,
          state.currentPlayListName,
          state.isMusicSelected,
        );
      })
    );
    final viewmodel = ref.read(playPageViewModelProvider.notifier);

    if(provValue == null) return CircularProgressIndicator();

    return VisibilityDetector(
      key: Key('play-page'),
      onVisibilityChanged: (info) {
        if(info.visibleFraction > 0.5) {
          viewmodel.onPageVisibled();
        }
      },
      child: Scaffold(
        body: Center(
          child: prov.when(
            data: (state) {
              final currentMusic = provValue.$1;
              final currentPlayListName = provValue.$2;
              final isMusicSelected = provValue.$3;
              if(!isMusicSelected) return buildUnselectedContent();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                      child: FittedBox(
                      child: Text(
                        currentMusic!.name,
                        style: TextStyle(
                          fontSize: 32
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32,),
                  MusicImage(image: currentMusic.musicSettings.picture.imageProvider),
                  Text(currentPlayListName),
                  SizedBox(height: 32,),
                  MusicSlider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MovePreviousButton(),
                      ToggleMusicModeButton(),
                      PlayButton(),
                      VolumeButton(),
                      MoveNextButton()
                    ],
                  )
                ],
              );
            }, 
            error: (e, _) => Text("error :"), 
            loading: () => CircularProgressIndicator()
          )
        ),
      ),
    );
  }

  Widget buildUnselectedContent() {
    return Center(
      child: Text("曲を選択してください！"),
    );
  }
}
