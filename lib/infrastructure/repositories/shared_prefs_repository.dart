import 'package:playremusica/core/result.dart';
import 'package:playremusica/domain/repositories/shared_prefs_repository_interface.dart';
import 'package:playremusica/domain/values/prefs_keys.dart';
import 'package:playremusica/infrastructure/core/shared_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@riverpod
ISharedPrefsRepository sharedPrefsRepository (Ref ref) {
  return SharedPrefsRepositoryImpl(
    prefs: ref.watch(sharedPreferencesProvider).requireValue
  );
}

class SharedPrefsRepositoryImpl implements ISharedPrefsRepository {
  late final SharedPreferences prefs;

  SharedPrefsRepositoryImpl({
    required this.prefs
  });
  
  @override
  Future<Result<String>> load(PrefsKeys key) async {
    final value = prefs.getString(key.value);

    if(value != null) {
      return Result(
        isSucceeded: true,
        value: value
      );
    } else {
      return Result(
        isSucceeded: false
      );
    }
  }

  @override
  Future<void> save(PrefsKeys key, String data) async {
    await prefs.setString(key.value, data);
  }
}
