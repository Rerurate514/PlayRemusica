import 'package:playremusica/application/notifiers/music_player_notifier.dart';
import 'package:playremusica/application/services/music_db_service.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/features/home/presentation/state/home_page_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_view_model.g.dart';

@riverpod
class HomePageViewModel extends _$HomePageViewModel {
  late final MusicDbService mds;
  late final MusicPlayerNotifier mpn;

  @override
  Future<HomePageViewState> build() async {
    mds = ref.watch(musicDbServiceProvider);
    mpn = ref.watch(musicPlayerProvider.notifier);

    final musics = await mds.readAllMusics();
    final playList = PlayList.createMainList(musics);
    mpn.loadInitialData(playList);
    
    return HomePageViewState(musics: musics);
  }
  
  Future<void> onTappedMusic(int index) async {
    await mpn.playAtIndex(index);
  }
}
