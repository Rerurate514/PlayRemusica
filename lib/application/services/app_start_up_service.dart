import 'package:playremusica/domain/repositories/music_db_reposiyory_interface.dart';
import 'package:playremusica/domain/repositories/music_file_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/music_db_repository.dart';
import 'package:playremusica/infrastructure/repositories/music_file_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_up_service.g.dart';

@riverpod
AppStartUpService appStartUpService(Ref ref) {
  return AppStartUpService(
    mdr: ref.read(musicDbRepositoryProvider), 
    mfr: ref.read(musicFileRepositoryProvider)
  );
}

class AppStartUpService {
  late final IMusicDbRepository mdr;
  late final IMusicFileRepository mfr;
  
  AppStartUpService({
    required this.mdr,
    required this.mfr
  });

  Future<void> initialize() async {
    final scanedResult = await mfr.scanMusicFiles();
    if(!scanedResult.isSucceeded) return;

    final musicsToSave = scanedResult.value!;
    if(musicsToSave.isEmpty) return;

    for(final music in musicsToSave) {
      await mdr.saveMusic(music);
    }
  }
}
