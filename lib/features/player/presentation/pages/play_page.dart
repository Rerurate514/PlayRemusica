import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/features/player/presentation/widgets/music_image.dart';
import 'package:playremusica/features/player/presentation/widgets/music_slider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PlayPage extends HookConsumerWidget {
  const PlayPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(playPageViewModelProvider);
    final viewmodel = ref.read(playPageViewModelProvider.notifier);

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
              if(state.currentMusic == null) return Text("曲を選択してください！");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.currentMusic!.name,
                    style: TextStyle(
                      fontSize: 32
                    ),
                  ),
                  SizedBox(height: 32,),
                  MusicImage(image: state.currentMusic!.musicSettings.picture.imageProvider),
                  Text(state.currentPlayListName),
                  SizedBox(height: 32,),
                  MusicSlider(),
                  
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
}
