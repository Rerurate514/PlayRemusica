import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'music_id.freezed.dart';

@freezed
sealed class MusicId with _$MusicId {
  const factory MusicId({
    required String id
  }) = _MusicId;

  factory MusicId.fromInputName(String inputName) {
    const uuid = Uuid();
    final uniqueId = uuid.v5(Namespace.url.value, inputName);
    return MusicId(id: uniqueId);
  }
}
