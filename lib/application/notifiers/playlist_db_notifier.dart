import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/entities/playlist_id.dart';
import 'package:playremusica/domain/repositories/playlist_db_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/playlist_db_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_db_notifier.g.dart';

@riverpod
class PlaylistDbNotifier extends _$PlaylistDbNotifier {
  late final IPlayListDbRepository _pdr;

  @override
  void build() {
    _pdr = ref.read(playListDbRepositoryProvider);
  }

  Future<void> deletePlayList(PlayListId id) async {
    _pdr.deletePlayList(id);
  }

  Future<void> savePlayList(PlayList playlist) async {
    _pdr.savePlayList(playlist);
  }

  Future<List<PlayList>> readAllPlayLists() async {
    return _pdr.readAllPlayLists();
  }

  Future<void> updatePlayList(PlayListId id, PlayList playlist) async {
    _pdr.updatePlayList(id, playlist);
  }
}
