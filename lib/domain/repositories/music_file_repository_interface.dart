import 'package:playremusica/domain/entities/music.dart';

abstract class IFileRepository {
  Future<List<Music>> scanMusicFiles(String directoryPath);
  Future<void> renameFile(String oldPath, String newName);
}
