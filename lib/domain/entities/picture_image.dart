import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_image.freezed.dart';

@freezed
sealed class PictureImage with _$PictureImage {
  const factory PictureImage({
    ImageProvider? imageProvider,
  }) = _PictureImage;
}
