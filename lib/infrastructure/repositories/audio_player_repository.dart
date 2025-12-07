import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/repositories/audio_player_repository_interface.dart';
import 'package:playremusica/infrastructure/core/audio_player_provider.dart';
import 'package:playremusica/infrastructure/repositories/helpers/current_lisntener_registry.dart';
import 'package:playremusica/infrastructure/repositories/helpers/duration_listener_registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_player_repository.g.dart';

@riverpod
IAudioPlayerRepository audioPlayerRepository (Ref ref) {
  return AudioPlayerRepositoryImpl(
    audioPlayer: ref.watch(audioPlayerProvider),
    clr: ref.watch(currentListenerResistryProvider),
    dlr: ref.watch(durationListenerResistryProvider)
  );
}

class AudioPlayerRepositoryImpl implements IAudioPlayerRepository {
  final AudioPlayer audioPlayer;
  final CurrentListenerResistry clr;
  final DurationListenerResistry dlr;

  StreamSubscription<void>? _completeSubscription;

  AudioPlayerRepositoryImpl({
    required this.audioPlayer,
    required this.clr,
    required this.dlr
  }){
    clr.setPlayingMusicCurrentListener(audioPlayer);
    dlr.setPlayingMusicDurationListener(audioPlayer);
  }

  @override
  double getCurrentSeconds() {
    return clr.currentSeconds;
  }

  @override
  double getDurationSeconds() {
    return dlr.durationSeconds;
  }

  @override
  double getVolume() {
    return audioPlayer.volume;
  }

  @override
  Future<void> initCompletedListener(Function() onMusicCompleted) async {
    _completeSubscription?.cancel();

    _completeSubscription = audioPlayer.onPlayerComplete.listen((event) {
      onMusicCompleted();
    });
  }

  @override
  Future<void> pause() async {
    await audioPlayer.pause();
  }

  @override
  Future<void> resume() async {
    await audioPlayer.resume();
  }

  @override
  Future<void> seek(int seconds) async {
    await audioPlayer.seek(Duration(seconds: seconds));
  }

  @override
  Future<void> setReleaseMode(ReleaseMode releaseMode) async {
    await audioPlayer.setReleaseMode(releaseMode);
  }

  @override
  Future<void> setVolume(double volume) async {
    await audioPlayer.setVolume(volume);
  }

  @override
  Future<void> start(Music music) async {
    try {
      await audioPlayer.stop();
      await audioPlayer.play(DeviceFileSource(music.path));
    } catch(e) {
      rethrow;
    }
  }
}
