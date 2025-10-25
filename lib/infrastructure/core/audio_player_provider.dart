import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_player_provider.g.dart';

@riverpod
AudioPlayer audioPlayer (Ref ref) {
  final audioPlayer = AudioPlayer();

  ref.onDispose(() {
    audioPlayer.dispose();
  });

  return audioPlayer;
}
