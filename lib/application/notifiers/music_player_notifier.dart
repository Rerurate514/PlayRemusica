import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/application/state/music_player_state.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/repositories/audio_player_repository_interface.dart';
import 'package:playremusica/domain/services/player_domain_service.dart';
import 'package:playremusica/domain/values/music_mode.dart';
import 'package:playremusica/domain/values/transition.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_player_notifier.g.dart';

@riverpod
class MusicPlayerNotifier extends _$MusicPlayerNotifier {
  late final IAudioPlayerRepository _audioRepo;

  @override
  MusicPlayerState build() {
    //_audioRepo = ref.read(audioPlayerRepositoryProvider);
    return MusicPlayerState(
      isPlaying: false,
      pds: PlayerDomainService(playList: PlayList.createEmpty())
    );
  }

  Future<void> loadInitialData(PlayList playList) async {
    state = state.copyWith(pds: PlayerDomainService(playList: playList));
  }

  Future<void> play() async {
    state = state.copyWith(isPlaying: true);

    _audioRepo.start(state.pds.getCurrentMusicId());
  }

  Future<void> pause() async {
    state = state.copyWith(isPlaying: false);
    _audioRepo.pause();
  }

  Future<void> resume() async {
    state = state.copyWith(isPlaying: true);
    _audioRepo.resume();
  }

  Future<void> seek(int seconds) async {
    _audioRepo.seek(seconds);
  }

  Future<void> setPlayList(PlayList newPlayList) async {
    state = state.copyWith(pds: PlayerDomainService(playList: newPlayList));
  }

  Future<void> moveNext() async {
    state.pds.handleMusicTransition(Next());
    play();
  }

  Future<void> movePrevious() async {
    state.pds.handleMusicTransition(Previous());
    play();
  }

  Future<void> moveRandom() async {
    state.pds.handleMusicTransition(Random());
    play();
  }

  Future<void> toggleMusicMode() async {
    final musicMode = state.pds.musicMode;
    switch(musicMode) {
      case Normal(): _audioRepo.setReleaseMode(ReleaseMode.loop);
      case Loop(): _audioRepo.setReleaseMode(ReleaseMode.release);
      case Shuffle(): _audioRepo.setReleaseMode(ReleaseMode.release);
    }
  }

  Future<void> setVolume(double volume) async {
    _audioRepo.setVolume(volume);
  }

  void _handlePlaybackCompletion() {

  }
}
