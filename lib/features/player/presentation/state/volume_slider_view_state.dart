import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_slider_view_state.freezed.dart';

@freezed
sealed class VolumeSliderViewState with _$VolumeSliderViewState {
  const factory VolumeSliderViewState({
    required bool isShowVolumeSlider
  }) = _VolumeSliderViewState;

  factory VolumeSliderViewState.createEmpty() {
    return VolumeSliderViewState(isShowVolumeSlider: false);
  }
}
