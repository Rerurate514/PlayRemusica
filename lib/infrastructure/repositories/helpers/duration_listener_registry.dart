import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'duration_listener_registry.g.dart';

@riverpod
DurationListenerResistry durationListenerResistry (Ref ref) {
  return DurationListenerResistry();
}

class DurationListenerResistry {
  double _durationSeconds = 0.0;
  double get durationSeconds => _durationSeconds;

  void setPlayingMusicDurationListener(AudioPlayer audioPlayer) {
    audioPlayer.onDurationChanged.listen((Duration duration) {
      _durationSeconds = duration.inSeconds.toDouble();
    });
  }
}
