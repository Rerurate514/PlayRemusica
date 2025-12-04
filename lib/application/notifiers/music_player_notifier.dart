import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/application/state/music_player_state.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/repositories/audio_player_repository_interface.dart';
import 'package:playremusica/domain/services/player_domain_service.dart';
import 'package:playremusica/domain/values/music_mode.dart';
import 'package:playremusica/domain/values/transition.dart';
import 'package:playremusica/infrastructure/repositories/audio_player_repository.dart';
import 'package:playremusica/infrastructure/repositories/providers/current_seconds_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_player_notifier.g.dart';

@Riverpod(keepAlive: true)
class MusicPlayerNotifier extends _$MusicPlayerNotifier {
  late final IAudioPlayerRepository apr;

  @override
  MusicPlayerState build() {
    apr = ref.read(audioPlayerRepositoryProvider);

    ref.listen(currentSecondsStreamProvider, (previous, next) {
      next.whenData((seconds) {
        state = state.copyWith(currentSeconds: seconds);
      });
    });

    return MusicPlayerState(
      isPlaying: false,
      isMusicSelected: false,
      pds: PlayerDomainService(playList: PlayList.createEmpty())
    );
  }

  Future<void> loadInitialData(PlayList playList) async {
    apr.initCompletedListener(_handlePlaybackCompletion);
    state = state.copyWith(pds: PlayerDomainService(playList: playList));
  }

  Music? getCurrentMusic() {
    return state.pds.getCurrentMusic();
  }

  PlayList getCurrentPlayList() {
    return state.pds.playList;
  }

  double getCurrentSeconds() {
    return apr.getCurrentSeconds();
  }

  double getDurationSeconds() {
    return apr.getDurationSeconds();
  }

  MusicMode getCurrentMusicMode() {
    return state.pds.musicMode;
  }

  Future<void> play() async {
    state = state.copyWith(isPlaying: true, isMusicSelected: true);
    final music = state.pds.getCurrentMusic();
    if(music == null) return;
    await apr.start(music);
  }

  Future<void> playAtIndex(int index) async {
    state = state.copyWith(isPlaying: true, isMusicSelected: true);
    state.pds.setPlayListIndex(index);
    final music = state.pds.getCurrentMusic();
    if(music == null) return;
    await apr.start(music);
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
