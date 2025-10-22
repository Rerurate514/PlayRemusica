import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/picture_image.dart';
import 'package:uuid/uuid.dart';

part 'playlist.freezed.dart';

@freezed
sealed class PlayList with _$PlayList {
  const factory PlayList({
    required Uuid id,
    required String name,
    required List<Uuid> list,
    required PictureImage picture,
  }) = _PlayList;
}
