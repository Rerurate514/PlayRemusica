import 'package:permission_handler/permission_handler.dart';
import 'package:playremusica/domain/repositories/permission_handler_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/permission_handler_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_handler_service.g.dart';

@riverpod
PermissionHandlerService permissionHandlerService(Ref ref) {
  return PermissionHandlerService(
    phr: ref.read(permissionHandlerRepositoryProvider)
  );
}

class PermissionHandlerService {
  late final IPermissionHandlerRepository phr;

  PermissionHandlerService({
    required this.phr
  });

  Future<Map<Permission, PermissionStatus>> request(List<Permission> permissions) async {
    return await phr.request(permissions);
  }
}
