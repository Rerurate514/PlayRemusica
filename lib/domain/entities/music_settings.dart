import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/picture_image.dart';

part 'music_settings.freezed.dart';

@freezed
sealed class MusicSettings with _$MusicSettings {
  const factory MusicSettings({
    @Default(0.4) double volume,
    required String lyrics,
    required PictureImage picture,
  }) = _MusicSettings;

  factory MusicSettings.createDefault() {
    return MusicSettings(
      lyrics: "", 
      picture: PictureImage()
    );
  }
}
