import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:uuid/uuid.dart';

abstract class IMusicRepository {
  Future<List<PlayList>> fetchAllPlaylists(); 
  Future<void> savePlaylist(PlayList playlist); 
  Future<void> deletePlaylist(Uuid id);

  Future<Music> getMusicById(Uuid id); 
  Future<void> updateMusicSettings(Uuid id, MusicSettings settings);
}
