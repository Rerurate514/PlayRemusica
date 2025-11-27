import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/music.dart';

part 'play_page_view_state.freezed.dart';

@freezed
sealed class PlayPageViewState with _$PlayPageViewState {
  const factory PlayPageViewState({
    required Music? currentMusic,
    required String currentPlayListName,
    required bool isMusicSelected,
    @Default(0.0) double currentSeconds
  }) = _PlayPageViewState;

  factory PlayPageViewState.createEmpty(){
    return PlayPageViewState(
      currentMusic: null,
      currentPlayListName: "",
      isMusicSelected: false
    );
  }
}
