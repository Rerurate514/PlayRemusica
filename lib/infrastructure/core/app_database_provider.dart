import 'package:playremusica/infrastructure/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database_provider.g.dart';

@riverpod
AppDatabase appDatabase (Ref ref) {
  return AppDatabase();
}
