import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/picture_image.dart';
import 'package:playremusica/domain/entities/playlist_id.dart';

part 'playlist.freezed.dart';

@freezed
sealed class PlayList with _$PlayList {
  const factory PlayList({
    required PlayListId id,
    required String name,
    required List<Music> list,
    required PictureImage picture,
  }) = _PlayList;

  factory PlayList.createEmpty() {
    return PlayList(
      id: PlayListId(value: ""),
      name: '',
      list: [],
      picture: PictureImage()
    );
  }

  factory PlayList.createMainList(List<Music> musics) {
    return PlayList(
      id: PlayListId(value: "in-main-list"), 
      name: "", 
      list: musics, 
      picture: PictureImage()
    );
  }
}
