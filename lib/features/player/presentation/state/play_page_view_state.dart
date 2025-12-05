import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/time.dart';
import 'package:playremusica/domain/values/music_mode.dart';

part 'play_page_view_state.freezed.dart';

@freezed
sealed class PlayPageViewState with _$PlayPageViewState {
  const factory PlayPageViewState({
    required Music? currentMusic,
    required String currentPlayListName,
    required bool isMusicSelected,
    required bool isPlaying,
    @Default(Time(rawSeconds: 0.0)) Time currentSeconds,
    @Default(Normal()) MusicMode currentMusicMode
  }) = _PlayPageViewState;

  factory PlayPageViewState.createEmpty(){
    return PlayPageViewState(
      currentMusic: null,
      currentPlayListName: "",
      isMusicSelected: false,
      isPlaying: false
    );
  }
}
