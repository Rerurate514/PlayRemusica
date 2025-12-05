import 'package:drift/drift.dart';

class MusicTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  TextColumn get filePath => text().unique()();
  RealColumn get volume => real().withDefault(const Constant(0.4))();
  TextColumn get lyrics => text()();
  BlobColumn get picture => blob().nullable()();
}
