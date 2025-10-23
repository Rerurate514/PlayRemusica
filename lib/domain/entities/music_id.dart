import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/picture_image.dart';

part 'music_id.freezed.dart';

@freezed
sealed class MusicId with _$MusicId {
  const factory MusicId({
    @Default(100) int volume,
    required String lyrics,
    required PictureImage picture,
  }) = _MusicId;
}
