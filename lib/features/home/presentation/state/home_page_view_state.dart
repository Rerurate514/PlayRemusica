import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:playremusica/domain/entities/music.dart';

part 'home_page_view_state.freezed.dart';

@freezed
sealed class HomePageViewState with _$HomePageViewState {
  const factory HomePageViewState({
    required List<Music> musics
  }) = _HomePageViewState;

  factory HomePageViewState.createEmpty(){
    return HomePageViewState(musics: []);
  }
}
