import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:playremusica/domain/repositories/music_db_reposiyory_interface.dart';
import 'package:playremusica/infrastructure/repositories/music_db_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_db_notifier.g.dart';

@riverpod
class MusicDbNotifier extends _$MusicDbNotifier {
  late final IMusicDbRepository _mdr;

  @override
  void build(){
    _mdr = ref.read(musicDbRepositoryProvider);
  }

  Future<void> deleteMusic(MusicId id) async {
    _mdr.deleteMusic(id);
  }

  Future<Music> readMusicById(MusicId id) async {
    return _mdr.readMusicById(id);
  }

  Future<void> saveMusic(Music music) async {
    _mdr.saveMusic(music);
  }

  Future<void> updateMusicSettings(MusicId id, MusicSettings settings) async {
    _mdr.updateMusicSettings(id, settings);
  }

  Future<List<Music>> readAllMusics() async {
    return _mdr.readAllMusics();
  }
}
