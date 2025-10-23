import 'package:freezed_annotation/freezed_annotation.dart';

part 'music_id.freezed.dart';

@freezed
sealed class MusicId with _$MusicId {
  const factory MusicId({
    required String id
  }) = _MusicId;
}
