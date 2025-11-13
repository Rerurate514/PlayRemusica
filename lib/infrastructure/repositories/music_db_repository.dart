import 'package:drift/drift.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:playremusica/domain/entities/picture_image.dart';
import 'package:playremusica/domain/repositories/music_db_reposiyory_interface.dart';
import 'package:playremusica/infrastructure/core/app_database_provider.dart';
import 'package:playremusica/infrastructure/database/app_database.dart';
import 'package:playremusica/infrastructure/repositories/helpers/picture_binary_converter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_db_repository.g.dart';

@riverpod
IMusicDbRepository musicDbRepository (Ref ref) {
  return MusicDbRepositoryImpl(
    db: ref.watch(appDatabaseProvider),
    pbc: ref.watch(pictureBinaryConverterProvider)
  );
}

class MusicDbRepositoryImpl implements IMusicDbRepository {
  final AppDatabase db;
  final PictureBinaryConverter pbc;

  MusicDbRepositoryImpl({
    required this.db,
    required this.pbc
  });

  @override
  Future<void> deleteMusic(MusicId id) async {
    final deleteQuery = db.delete(db.musicTable)
      ..where((tbl) => tbl.id.equals(id.id));

    await deleteQuery.go();
  }

  @override
  Future<Music> readMusicById(MusicId id) async {
    final query = db.select(db.musicTable)
      ..where((tbl) => tbl.id.equals(id.id));

    final MusicTableData data = await query.getSingle();

    return _toDomain(data);
  }

  @override
  Future<void> saveMusic(Music music) async {
    final image = music.musicSettings.picture.imageProvider;

    final Uint8List? pictureBytes = image != null 
    ? await pbc.convertImageToBytes(image)
    : null;
    
    db.into(db.musicTable)
      .insert(MusicTableCompanion(
        id: Value(music.id.id),
        name: Value(music.name),
        filePath: Value(music.path),
        volume: Value(music.musicSettings.volume),
        lyrics: Value(music.musicSettings.lyrics),
        picture: Value(pictureBytes)
      ));
  }

  @override
  Future<void> updateMusicSettings(MusicId id, MusicSettings settings) async {
    final image = settings.picture.imageProvider;

    final Uint8List? pictureBytes = image != null 
    ? await pbc.convertImageToBytes(image)
    : null;

    final query = db.update(db.musicTable)
      ..where((tbl) => tbl.id.equals(id.id));

    await query.write(
      MusicTableCompanion(
        volume: Value(settings.volume),
        lyrics: Value(settings.lyrics),
        picture: Value(pictureBytes)
      )
    );
  }

  Music _toDomain(MusicTableData data){
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
  }
  
  @override
  Future<List<Music>> readAllMusics() async {
    final query = await db.select(db.musicTable).get();
    final List<Music> musics = query.map((MusicTableData data) {
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

    return musics;
  }
}
