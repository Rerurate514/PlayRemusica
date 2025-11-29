import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/application/notifiers/music_player_notifier.dart';
import 'package:playremusica/features/player/presentation/state/play_page_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_page_view_model.g.dart';

@riverpod
class PlayPageViewModel extends _$PlayPageViewModel {
  @override
  PlayPageViewState build() {
    final musicPlayerStaticInfo = ref.watch(musicPlayerProvider.select((state) => (
        state.pds.getCurrentMusic(),
        state.pds.playList.name,
        state.isMusicSelected,
    )));
    
    final isPlaying = ref.watch(musicPlayerProvider.select((state) => state.isPlaying));
    final currentSeconds = ref.watch(musicPlayerProvider.select((state) => state.currentSeconds));

    return PlayPageViewState(
      currentMusic: musicPlayerStaticInfo.$1,
      currentPlayListName: musicPlayerStaticInfo.$2,
      isMusicSelected: musicPlayerStaticInfo.$3,
      isPlaying: isPlaying,
      currentSeconds: currentSeconds
    );
  }

  void pause() {
    final prov = ref.watch(musicPlayerProvider.notifier);
    prov.pause();
  }

  void resume() {
    final prov = ref.watch(musicPlayerProvider.notifier);
    prov.resume();
  }

  void seek(double seconds) {
    final prov = ref.watch(musicPlayerProvider.notifier);
    prov.seek(seconds.toInt());
  }

  double getCurrentSeconds() {
    return state.value?.currentSeconds ?? 0.0;
  }

  double getDurationSeconds() {
    final prov = ref.watch(musicPlayerProvider.notifier);
    return prov.getDurationSeconds();
  }

  void onPageVisibled() {
    ref.invalidateSelf();
  }
}
