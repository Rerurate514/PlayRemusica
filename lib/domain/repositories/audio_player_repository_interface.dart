import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/domain/entities/music.dart';

abstract class IAudioPlayerRepository {
  void start(Music music);
  void pause();
  void resume();
  void seek(int seconds);
  void setVolume(double volume);
  double getCurrentSeconds();
  double getDurationSeconds();
  void setReleaseMode(ReleaseMode releaseMode);
  void initCompletedListener(Function() onMusicCompleted);
}
