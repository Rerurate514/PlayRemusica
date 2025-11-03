import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'playlist_id.freezed.dart';

@freezed
sealed class PlayListId with _$PlayListId {
  const factory PlayListId({
    required String id
  }) = _PlayListId;

    factory PlayListId.fromInputName(String inputName) {
    const uuid = Uuid();
    final uniqueId = uuid.v5(Namespace.url.value, inputName);
    return PlayListId(id: uniqueId);
  }
}
