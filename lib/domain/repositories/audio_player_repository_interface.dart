import 'package:audioplayers/audioplayers.dart';
import 'package:playremusica/domain/entities/music.dart';

abstract class IAudioPlayerRepository {
  void start(Music music);
  void pause();
  void resume();
  void seek(double second);
  void setVolume(int volume);
  void getCurrentSeconds();
  void getDurationSeconds();
  void setReleaseMode(ReleaseMode releaseMode);
  void initCompletedListener(Function() onMusicCompleted);
}
