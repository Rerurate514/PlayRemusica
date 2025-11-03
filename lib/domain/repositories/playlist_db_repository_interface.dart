import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/entities/playlist_id.dart';

abstract class IPlayListDbRepository {
  Future<void> savePlayList(PlayList playlist);
  Future<List<PlayList>> readAllPlayLists();
  Future<void> deletePlayList(PlayListId id);
  Future<void> updatePlayList(PlayListId id, PlayList playlist);
}
