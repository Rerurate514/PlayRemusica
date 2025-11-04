import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:playremusica/domain/repositories/music_db_reposiyory_interface.dart';
import 'package:playremusica/infrastructure/repositories/music_db_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_db_service.g.dart';

@riverpod
MusicDbService musicDbService(Ref ref) {
  return MusicDbService(
    mdr: ref.watch(musicDbRepositoryProvider)
  );
}

class MusicDbService {
  late final IMusicDbRepository mdr;

  MusicDbService({
    required this.mdr
  });

  Future<void> deleteMusic(MusicId id) async {
    mdr.deleteMusic(id);
  }

  Future<Music> readMusicById(MusicId id) async {
    return mdr.readMusicById(id);
  }

  Future<void> saveMusic(Music music) async {
    mdr.saveMusic(music);
  }

  Future<void> updateMusicSettings(MusicId id, MusicSettings settings) async {
    mdr.updateMusicSettings(id, settings);
  }

  Future<List<Music>> readAllMusics() async {
    return mdr.readAllMusics();
  }
}
