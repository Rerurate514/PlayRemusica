import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playremusica/infrastructure/models/music_table.dart';
import 'package:playremusica/infrastructure/models/playlist_items_table.dart';
import 'package:playremusica/infrastructure/models/playlist_table.dart';

import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    MusicTable,
    PlayListTable,
    PlaylistItemsTable
  ]
)
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  AppDatabase._(): super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) {
      return m.createAll();
    }
  );

  factory AppDatabase() {
    _instance ??= AppDatabase._();
    return _instance!;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final folder = await getApplicationDocumentsDirectory();
    final file = File(p.join(folder.path, 'app_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
