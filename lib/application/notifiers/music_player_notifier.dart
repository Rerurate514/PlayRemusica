import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/application/state/music_player_state.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/repositories/audio_player_repository_interface.dart';
import 'package:playremusica/domain/services/player_domain_service.dart';
import 'package:playremusica/domain/values/music_mode.dart';
import 'package:playremusica/domain/values/transition.dart';
import 'package:playremusica/infrastructure/repositories/audio_player_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_player_notifier.g.dart';

@riverpod
class MusicPlayerNotifier extends _$MusicPlayerNotifier {
  late final IAudioPlayerRepository apr;

  @override
  MusicPlayerState build() {
    apr = ref.read(audioPlayerRepositoryProvider);
    return MusicPlayerState(
      isPlaying: false,
      pds: PlayerDomainService(playList: PlayList.createEmpty())
    );
  }

  Future<void> loadInitialData(PlayList playList) async {
    apr.initCompletedListener(_handlePlaybackCompletion);
    state = state.copyWith(pds: PlayerDomainService(playList: playList));
  }

  Music getCurrentMusic() {
    return state.pds.getCurrentMusic();
  }

  PlayList getCurrentPlayList() {
    return state.pds.playList;
  }

  Future<void> play() async {
    state = state.copyWith(isPlaying: true);
    await apr.start(state.pds.getCurrentMusic());
  }

  Future<void> playAtIndex(int index) async {
    state.pds.setPlayListIndex(index);
    await apr.start(state.pds.getCurrentMusic());
  }

  Future<void> pause() async {
    state = state.copyWith(isPlaying: false);
    await apr.pause();
  }

  Future<void> resume() async {
    state = state.copyWith(isPlaying: true);
    await apr.resume();
  }

  Future<void> seek(int seconds) async {
    await apr.seek(seconds);
  }

  Future<void> setPlayList(PlayList newPlayList) async {
    state = state.copyWith(pds: PlayerDomainService(playList: newPlayList));
  }

  Future<void> moveNext() async {
    state.pds.handleMusicTransition(Next());
    await play();
  }

  Future<void> movePrevious() async {
    state.pds.handleMusicTransition(Previous());
    await play();
  }

  Future<void> moveRandom() async {
    state.pds.handleMusicTransition(Random());
    await play();
  }

  Future<void> toggleMusicMode() async {
    final musicMode = state.pds.musicMode;
    switch(musicMode) {
      case Normal(): apr.setReleaseMode(ReleaseMode.loop);
      case Loop(): apr.setReleaseMode(ReleaseMode.release);
      case Shuffle(): apr.setReleaseMode(ReleaseMode.release);
    }
  }

  Future<void> setVolume(double volume) async {
    await apr.setVolume(volume);
  }

  void _handlePlaybackCompletion() {
    
  }
}
