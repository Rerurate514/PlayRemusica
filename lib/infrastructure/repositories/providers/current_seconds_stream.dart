import 'package:playremusica/infrastructure/core/audio_player_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_seconds_stream.g.dart';

@riverpod
Stream<double> currentSecondsStream(Ref ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);

  return audioPlayer.onPositionChanged
    .map((duration) => duration.inSeconds.toDouble())
    .asBroadcastStream();
}
