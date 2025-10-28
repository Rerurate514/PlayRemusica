import 'dart:typed_data';

import 'package:drift/drift.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/entities/playlist_id.dart';
import 'package:playremusica/domain/repositories/playlist_db_repository_interface.dart';
import 'package:playremusica/infrastructure/core/app_database_provider.dart';
import 'package:playremusica/infrastructure/database/app_database.dart';
import 'package:playremusica/infrastructure/repositories/helpers/picture_binary_converter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlist_db_repository.g.dart';

@riverpod
IPlayListDbRepository playListDbRepository(Ref ref) {
  return PlayListDbRepositoryImpl(
    db: ref.watch(appDatabaseProvider),
    pbc: ref.watch(pictureBinaryConverterProvider)
  );
}

class PlayListDbRepositoryImpl implements IPlayListDbRepository {
  final AppDatabase db;
  final PictureBinaryConverter pbc;

  PlayListDbRepositoryImpl({
    required this.db,
    required this.pbc
  });

  @override
  Future<void> deletePlayList(PlayListId id) async {
    final deleteQuery = db.delete(db.playListTable)
    ..where((tbl) => tbl.id.equals(id.id));

    await deleteQuery.go();
  }

  @override
  Future<List<PlayList>> readAllPlayLists() {
    
  }

  @override
  Future<void> savePlayList(PlayList playlist) async {
    final image = playlist.picture.imageProvider;

    final Uint8List? pictureBytes = image != null 
    ? await pbc.convertImageToBytes(image)
    : null;

    db.into(db.playListTable)
      .insert(PlayListTableCompanion(
        id: Value(playlist.id.id),
        name: Value(playlist.name),
        picture: Value(pictureBytes)
      ));
  }

  @override
  Future<void> updatePlayList(PlayListId id) {
    // TODO: implement updatePlayList
    throw UnimplementedError();
  }
}