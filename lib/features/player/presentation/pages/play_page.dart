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
import 'package:playremusica/features/player/presentation/widgets/volume_switcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PlayPage extends HookConsumerWidget {
  const PlayPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provValue = ref.watch(
      playPageViewModelProvider.select((state) {
        return (
          state.currentMusic,
          state.currentPlayListName,
          state.isMusicSelected,
        );
      })
    );
    final viewmodel = ref.read(playPageViewModelProvider.notifier);

    final currentMusic = provValue.$1;
    final currentPlayListName = provValue.$2;
    final isMusicSelected = provValue.$3;
    if(!isMusicSelected) return buildUnselectedContent();

    return VisibilityDetector(
      key: Key('play-page'),
      onVisibilityChanged: (info) {
        if(info.visibleFraction > 0.5) {
          viewmodel.onPageVisibled();
        }
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Column(
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
                  const SizedBox(height: 32,),
                  MusicImage(image: currentMusic.musicSettings.picture.imageProvider),
                  Text(currentPlayListName),
                  const SizedBox(height: 32,),
                  MusicSlider(),
                  const SizedBox(height: 32,),
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
              ),
              buildVolumeSwitcher()
            ],
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

  Widget buildVolumeSwitcher() {
    return Positioned.fill(
      child: VolumeSwitcher(), 
    );
  }
}
