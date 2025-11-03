import 'package:playremusica/core/result.dart';
import 'package:playremusica/domain/entities/music.dart';

abstract class IMusicFileRepository {
  Future<Result<List<Music>>> scanMusicFiles(String directoryPath);
  Future<Result<void>> renameFile(String oldPath, String newName);
}
