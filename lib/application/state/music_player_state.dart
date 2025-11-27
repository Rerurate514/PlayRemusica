import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/services/player_domain_service.dart';

part 'music_player_state.freezed.dart';

@freezed
sealed class MusicPlayerState with _$MusicPlayerState {
  const factory MusicPlayerState({
    required bool isPlaying,
    required bool isMusicSelected,
    required PlayerDomainService pds,
    @Default(0.0) double currentSeconds
  }) = _MusicPlayerState;
}
