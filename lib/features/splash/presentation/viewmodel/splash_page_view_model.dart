import 'package:playremusica/application/services/app_start_up_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_page_view_model.g.dart';

@riverpod
class SplashPageViewModel extends _$SplashPageViewModel {
  late final AppStartUpService asus;

  @override
  Future<void> build() async {
    asus = ref.watch(appStartUpServiceProvider);
  }

  Future<void> initialize() async {
    state = AsyncLoading();
    await asus.initialize();
    state = AsyncData(null);
  }

  Future<void> restartAppInitialization() async {
    ref.invalidateSelf();
  }
}
