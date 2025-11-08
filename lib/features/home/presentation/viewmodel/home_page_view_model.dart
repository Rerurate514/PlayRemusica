import 'package:playremusica/application/services/app_start_up_service.dart';
import 'package:playremusica/application/services/music_db_service.dart';
import 'package:playremusica/features/home/presentation/state/home_page_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_view_model.g.dart';

@riverpod
class HomePageViewModel extends _$HomePageViewModel {
  late final MusicDbService mds;
  late final AppStartUpService asus;

  @override
  HomePageViewState build() {
    mds = ref.watch(musicDbServiceProvider);
    asus = ref.watch(appStartUpServiceProvider);

    return HomePageViewState.createEmpty();
  }

  void initialize() async {
    final musics = await mds.readAllMusics();
    state = state.copyWith(musics: musics);
  }
}
