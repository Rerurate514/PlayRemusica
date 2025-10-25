import 'package:drift/drift.dart';
import 'package:playremusica/infrastructure/models/music_table.dart';
import 'package:playremusica/infrastructure/models/playlist_table.dart';

class PlaylistItemsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get playlistId => text().references(PlayListTable, #id)();
  TextColumn get musicId => text().references(MusicTable, #id)();
  IntColumn get itemOrder => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, musicId};
}
