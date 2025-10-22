import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'music.freezed.dart';

@freezed
sealed class Music with _$Music {
  const factory Music({
    required Uuid id,
    required String name,
    required String path,
    @Default(100) int volume,
    required String lyrics,
    String? picture,
  }) = _Music;
}
