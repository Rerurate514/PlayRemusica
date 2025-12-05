
import 'package:playremusica/features/player/presentation/state/volume_slider_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'volume_slider_view_model.g.dart';

@riverpod
class VolumeSliderViewModel extends _$VolumeSliderViewModel {
  @override
  VolumeSliderViewState build() {
    return VolumeSliderViewState.createEmpty();
  }

  void switchVolumeSlider() {
    state = state.copyWith(isShowVolumeSlider: !state.isShowVolumeSlider);
  }
}
