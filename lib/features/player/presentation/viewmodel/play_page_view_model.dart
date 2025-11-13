import 'package:playremusica/features/player/presentation/state/play_page_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_page_view_model.g.dart';

@riverpod
class PlayPageViewModel extends _$PlayPageViewModel {
  @override
  Future<PlayPageViewState> build() async {
    return PlayPageViewState();
  }
}
