import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_lisntener_registry.g.dart';

@riverpod
CurrentListenerResistry currentListenerResistry (Ref ref) {
  return CurrentListenerResistry();
}

class CurrentListenerResistry {
  double _currentSeconds = 0.0;
  double get currentSeconds => _currentSeconds;

  void setPlayingMusicCurrentListener(AudioPlayer audioPlayer) {
    audioPlayer.onPositionChanged.listen((Duration duration) {
      _currentSeconds = duration.inSeconds.toDouble();
    });
  }
}
