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
    final currentMusicMode = ref.watch(musicPlayerProvider.select((state) => state.currentMusicMode));

    return PlayPageViewState(
      currentMusic: musicPlayerStaticInfo.$1,
      currentPlayListName: musicPlayerStaticInfo.$2,
      isMusicSelected: musicPlayerStaticInfo.$3,
      isPlaying: isPlaying,
      currentSeconds: currentSeconds,
      currentMusicMode: currentMusicMode,
    );
  }

  void pause() {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.pause();
  }

  void resume() {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.resume();
  }

  void seek(double seconds) {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.seek(seconds.toInt());
  }

  double getCurrentSeconds() {
    return state.currentSeconds;
  }

  double getDurationSeconds() {
    final prov = ref.read(musicPlayerProvider.notifier);
    return prov.getDurationSeconds();
  }

  double getVolume() {
    final prov = ref.read(musicPlayerProvider.notifier);
    return prov.getVolume();
  }

  void moveNext() {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.moveNext();
  }

  void movePrevious() {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.movePrevious();
  }

  void moveRandom() {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.moveRandom();
  }

  void toggleMusicMode() {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.toggleMusicMode();
  }

  void setVolume(double volume) {
    final prov = ref.read(musicPlayerProvider.notifier);
    prov.setVolume(volume);
  }

  void onPageVisibled() {
    ref.invalidateSelf();
  }
}
