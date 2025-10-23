import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';

part 'music.freezed.dart';

@freezed
sealed class Music with _$Music {
  const factory Music({
    required MusicId id,
    required String name,
    required String path,
    required MusicSettings musicSettings
  }) = _Music;
}
