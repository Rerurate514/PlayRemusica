import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/picture_image.dart';

part 'music_settings.freezed.dart';

@freezed
sealed class MusicSettings with _$MusicSettings {
  const factory MusicSettings({
    @Default(100) int volume,
    required String lyrics,
    required PictureImage picture,
  }) = _MusicSettings;
}
