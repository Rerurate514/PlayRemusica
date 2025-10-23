import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/picture_image.dart';

part 'playlist_id.freezed.dart';

@freezed
sealed class PlayListId with _$PlayListId {
  const factory PlayListId({
    @Default(100) int volume,
    required String lyrics,
    required PictureImage picture,
  }) = _PlayListId;
}
