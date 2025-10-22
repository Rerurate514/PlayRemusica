import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:uuid/uuid.dart';

part 'music.freezed.dart';

@freezed
sealed class Music with _$Music {
  const factory Music({
    required Uuid id,
    required String name,
    required String path,
    required MusicSettings musicSettings
  }) = _Music;
}
