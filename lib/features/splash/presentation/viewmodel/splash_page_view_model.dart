import 'package:playremusica/application/services/app_start_up_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_page_view_model.g.dart';

@riverpod
class SplashPageViewModel extends _$SplashPageViewModel {
  late final AppStartUpService _asus;

  @override
  Future<void> build() async {
    _asus = ref.watch(appStartUpServiceProvider);
    await _asus.initialize();
  }

  Future<void> restartAppInitialization() async {
    ref.invalidateSelf();
  }
}
