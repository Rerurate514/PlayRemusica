import 'dart:io';

import 'package:playremusica/core/exception/file_rename_exception.dart';
import 'package:playremusica/core/result.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/music_id.dart';
import 'package:playremusica/domain/entities/music_settings.dart';
import 'package:playremusica/domain/repositories/music_db_reposiyory_interface.dart';
import 'package:playremusica/domain/repositories/music_file_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/helpers/file_name_trimer.dart';
import 'package:playremusica/infrastructure/repositories/music_db_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_file_repository.g.dart';

@riverpod
IMusicFileRepository musicFileRepository(Ref ref) {
  return MusicFileRepositoryImpl(
    fnt: ref.watch(fileNameTrimerProvider),
    mdr: ref.watch(musicDbRepositoryProvider)
  );
}

class MusicFileRepositoryImpl implements IMusicFileRepository {
  final FileNameTrimer fnt;
  final IMusicDbRepository mdr;

  MusicFileRepositoryImpl({
    required this.fnt,
    required this.mdr
  });

  @override
  Future<Result<void>> renameFile(String oldPath, String newName) async {
    File file = File(oldPath);

    try{
      final path = file.path;
      final ex = path.lastIndexOf(Platform.pathSeparator);
      final newPath = path.substring(0, ex + 1) + newName;
      await file.rename(newPath);
      return Result(isSucceeded: true);
    } catch(e) {
      throw FileRenameException(oldPath, newName);
    }
  }

  @override
  Future<Result<List<Music>>> scanMusicFiles() async {
    final list = await _fetchFileFromDownloadDir();
    final audioList = _filterAudioFiles(list);
    final pathLists = fnt.convertFileNameToPathString(audioList).toSet();
    final musicList = await mdr.readAllMusics();
    final musicPaths = musicList.map((music) => music.path).toSet();

    final diffs = pathLists.difference(musicPaths).toList();
    final diffsMusics = diffs.map((path) {
      final fileNameWithExtension = path.substring(path.lastIndexOf(Platform.pathSeparator) + 1);
      final musicName = fileNameWithExtension.substring(0, fileNameWithExtension.lastIndexOf('.') != -1 ? fileNameWithExtension.lastIndexOf('.') : fileNameWithExtension.length);

      return Music(
        id: MusicId.fromInputName(path), 
        name: musicName, 
        path: path,
        musicSettings: MusicSettings.createDefault()
      );
    }).toList();

    return Result(isSucceeded: true, value: diffsMusics);
  }
  
  Future<List<FileSystemEntity>> _fetchFileFromDownloadDir() async {
    Directory dir = Directory("/storage/emulated/0/Download/");
    List<FileSystemEntity> result = dir.listSync();

    return result;
  }

  List<FileSystemEntity> _filterAudioFiles(List<FileSystemEntity> list){
    return list.where((file) => 
      file.path.endsWith(".mp3") ||
      file.path.endsWith(".wav") ||
      file.path.endsWith(".aac") ||
      file.path.endsWith(".m4a") ||
      file.path.endsWith(".m4b") ||
      file.path.endsWith(".ogg") ||
      file.path.endsWith(".flac")
    ).toList();
  }
}
