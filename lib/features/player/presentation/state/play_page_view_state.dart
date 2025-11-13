import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_page_view_state.freezed.dart';

@freezed
sealed class PlayPageViewState with _$PlayPageViewState {
  const factory PlayPageViewState() = _PlayPageViewState;

  factory PlayPageViewState.createEmpty(){
    return PlayPageViewState();
  }
}
