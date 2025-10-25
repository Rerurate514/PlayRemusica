import 'package:drift/drift.dart';

class PlayListTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text()();
  BlobColumn get picture => blob()();
}
