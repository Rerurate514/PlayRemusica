import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist_id.freezed.dart';

@freezed
sealed class PlayListId with _$PlayListId {
  const factory PlayListId({
    required String id
  }) = _PlayListId;
}
