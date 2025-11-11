import 'package:playremusica/application/services/music_db_service.dart';
import 'package:playremusica/features/home/presentation/state/home_page_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_view_model.g.dart';

@riverpod
class HomePageViewModel extends _$HomePageViewModel {
  late final MusicDbService mds;

  @override
  Future<HomePageViewState> build() async {
    mds = ref.watch(musicDbServiceProvider);

    final musics = await mds.readAllMusics();
    return HomePageViewState(musics: musics);
  }
}
