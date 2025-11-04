import 'package:playremusica/core/result.dart';
import 'package:playremusica/domain/values/prefs_keys.dart';

abstract class ISharedPrefsRepository {
  Future<void> save(PrefsKeys key, String data);
  Future<Result<String>> load(PrefsKeys key);
}
