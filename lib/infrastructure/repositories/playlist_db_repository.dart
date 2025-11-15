import 'package:drift/drift.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:playremusica/domain/entities/picture_image.dart';
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
    ..where((tbl) => tbl.id.equals(id.value));

    await deleteQuery.go();
  }

  @override
  Future<void> savePlayList(PlayList playlist) async {
    final image = playlist.picture.imageProvider;

    final Uint8List? pictureBytes = image != null 
    ? await pbc.convertImageToBytes(image)
    : null;

    db.into(db.playListTable)
      .insert(PlayListTableCompanion(
        id: Value(playlist.id.value),
        name: Value(playlist.name),
        picture: Value(pictureBytes)
      ));
  }

  @override
  Future<List<PlayList>> readAllPlayLists() async {
    final Map<String, List<MusicTableData>> playlistMusicMap = {};

    final query = db.select(db.playListTable).join([
      innerJoin(
        db.playlistItemsTable, 
        db.playlistItemsTable.playlistId.equalsExp(db.playListTable.id)
      ),
      innerJoin(
        db.musicTable, 
        db.musicTable.id.equalsExp(db.playlistItemsTable.musicId))
    ]);

    final result = await query.get();

    for (final row in result) {
      final playlistData = row.readTable(db.playListTable);
      final musicData = row.readTable(db.musicTable);

      final playlistId = playlistData.id;

      if (!playlistMusicMap.containsKey(playlistId)) {
        playlistMusicMap[playlistId] = [];
      }
      playlistMusicMap[playlistId]!.add(musicData);
    }

    final allPlayListBasicData = await db.select(db.playListTable).get();

    final List<PlayList> playlists = allPlayListBasicData.map((PlayListTableData data) {
      final String playlistId = data.id;
      
      final List<MusicTableData> musicDataList = playlistMusicMap[playlistId] ?? [];
      
      final List<Music> musicList = musicDataList.map((data) {
        return Music(
          id: MusicId(value: data.id), 
          name: data.name, 
          path: data.filePath, 
          musicSettings: MusicSettings(
            lyrics: data.lyrics, 
            picture: PictureImage(
              imageProvider: data.picture != null ? pbc.convertBytesToImage(data.picture!) : null
            )
          )
        );
      }).toList();
      
      return PlayList(
        id: PlayListId(value: data.id),
        name: data.name,
        list: musicList,
        picture: PictureImage(
          imageProvider: data.picture != null ? pbc.convertBytesToImage(data.picture!) : null
        )
      );
    }).toList();

    return playlists;
  }

  @override
  Future<void> updatePlayList(PlayListId id, PlayList playlist) async {
    final image = playlist.picture.imageProvider;

    final Uint8List? pictureBytes = image != null 
    ? await pbc.convertImageToBytes(image)
    : null;

    final query = db.update(db.playListTable)
      ..where((tbl) => tbl.id.equals(id.value));

    await query.write(
      PlayListTableCompanion(
        name: Value(playlist.name),
        picture: Value(pictureBytes),
      )
    );
  }
}
