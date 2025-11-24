import 'package:playremusica/application/notifiers/music_player_notifier.dart';
import 'package:playremusica/application/state/music_player_state.dart';
import 'package:playremusica/features/player/presentation/state/play_page_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_page_view_model.g.dart';

@riverpod
class PlayPageViewModel extends _$PlayPageViewModel {
  @override
  Future<PlayPageViewState> build() async {
    final MusicPlayerState musicPlayerState = ref.read(musicPlayerProvider);
    return PlayPageViewState(
      currentMusic: musicPlayerState.pds.getCurrentMusic(),
      currentPlayListName: musicPlayerState.pds.playList.name,
      isMusicSelected: musicPlayerState.isMusicSelected
    );
  }

  void onPageVisibled() {
    ref.invalidateSelf();
  }
}
