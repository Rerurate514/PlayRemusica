import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_image.freezed.dart';

@freezed
sealed class PictureImage with _$PictureImage {
  const factory PictureImage({
    String? imageBytes,
  }) = _PictureImage;
}
