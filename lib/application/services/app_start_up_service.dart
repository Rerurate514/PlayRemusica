import 'package:playremusica/core/result.dart';
import 'package:playremusica/core/settings/permissions.dart';
import 'package:playremusica/domain/repositories/music_db_reposiyory_interface.dart';
import 'package:playremusica/domain/repositories/music_file_repository_interface.dart';
import 'package:playremusica/domain/repositories/permission_handler_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/music_db_repository.dart';
import 'package:playremusica/infrastructure/repositories/music_file_repository.dart';
import 'package:playremusica/infrastructure/repositories/permission_handler_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_up_service.g.dart';

@riverpod
AppStartUpService appStartUpService(Ref ref) {
  return AppStartUpService(
    mdr: ref.read(musicDbRepositoryProvider), 
    mfr: ref.read(musicFileRepositoryProvider),
    phr: ref.read(permissionHandlerRepositoryProvider)
  );
}

class AppStartUpService {
  late final IMusicDbRepository mdr;
  late final IMusicFileRepository mfr;
  late final IPermissionHandlerRepository phr;
  
  AppStartUpService({
    required this.mdr,
    required this.mfr,
    required this.phr
  });

  Future<Result<void>> initialize() async {
    await phr.request(permissions);

    final scanedResult = await mfr.scanMusicFiles();
    if(!scanedResult.isSucceeded) return Result(isSucceeded: false);

    final musicsToSave = scanedResult.value!;
    if(musicsToSave.isEmpty) return Result(isSucceeded: false);

    for(final music in musicsToSave) {
      await mdr.saveMusic(music);
    }

    return Result(isSucceeded: true);
  }
}
