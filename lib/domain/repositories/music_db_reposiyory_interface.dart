import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';

abstract class IMusicDbRepository {
  Future<void> saveMusic(Music music);
  Future<Music> readMusicById(MusicId id);
  Future<List<Music>> readAllMusics();
  Future<void> deleteMusic(MusicId id);
  Future<void> updateMusicSettings(MusicId id, MusicSettings settings);
}
