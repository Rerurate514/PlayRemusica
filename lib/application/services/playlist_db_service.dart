import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/entities/playlist_id.dart';
import 'package:playremusica/domain/repositories/playlist_db_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/playlist_db_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_db_service.g.dart';

@riverpod
PlaylistDbService playlistDbService(Ref ref) {
  return PlaylistDbService(
    pdr: ref.read(playListDbRepositoryProvider)
  );
}

class PlaylistDbService {
  late final IPlayListDbRepository pdr;

  PlaylistDbService({
    required this.pdr
  });

  Future<void> deletePlayList(PlayListId id) async {
    pdr.deletePlayList(id);
  }

  Future<void> savePlayList(PlayList playlist) async {
    pdr.savePlayList(playlist);
  }

  Future<List<PlayList>> readAllPlayLists() async {
    return pdr.readAllPlayLists();
  }

  Future<void> updatePlayList(PlayListId id, PlayList playlist) async {
    pdr.updatePlayList(id, playlist);
  }
}
