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
  void initCompletedListener(Function() onMusicCompleted) {
    audioPlayer.onPlayerComplete.listen((event) {
      onMusicCompleted();
    });
  }

  @override
  void pause() {
    audioPlayer.pause();
  }

  @override
  void resume() {
    audioPlayer.resume();
  }

  @override
  void seek(int seconds) {
    audioPlayer.seek(Duration(seconds: seconds));
  }

  @override
  void setReleaseMode(ReleaseMode releaseMode) {
    audioPlayer.setReleaseMode(releaseMode);
  }

  @override
  void setVolume(double volume) {
    audioPlayer.setVolume(volume);
  }

  @override
  void start(Music music) {
    try {
      audioPlayer.play(DeviceFileSource(music.path));
    } catch(e) {
      rethrow;
    }
  }
}
