import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/entities/playlist_id.dart';

abstract class IPlayListDbRepository {
  Future<void> savePlayList(PlayList playlist);
  Future<PlayList> readMusicById(PlayListId id);
  Future<List<PlayList>> readAllPlayLists();
  Future<void> deletePlayList(PlayListId id);
  Future<void> updateList(PlayListId id, List<Music> musics);
}
