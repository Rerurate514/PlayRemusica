import 'package:drift/drift.dart';

class MusicTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get filePath => text().unique()();
  IntColumn get volume => integer().withDefault(const Constant(40))();
  TextColumn get lyrics => text()();
  BlobColumn get picture => blob()();
}
