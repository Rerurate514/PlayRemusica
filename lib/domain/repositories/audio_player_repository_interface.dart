import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/domain/entities/music.dart';

abstract class IAudioPlayerRepository {
  Future<void> start(Music music);
  Future<void> pause();
  Future<void> resume();
  Future<void> seek(int seconds);
  Future<void> setVolume(double volume);
  double getCurrentSeconds();
  double getDurationSeconds();
  double getVolume();
  Future<void> setReleaseMode(ReleaseMode releaseMode);
  Future<void> initCompletedListener(Function() onMusicCompleted);
}
