import 'package:permission_handler/permission_handler.dart';
import 'package:playremusica/core/exception/permission_handle_exception.dart';
import 'package:playremusica/domain/repositories/permission_handler_repository_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_handler_repository.g.dart';

@riverpod
IPermissionHandlerRepository permissionHandlerRepository(Ref ref) {
  return PermissionHandlerRepositoryImpl();
}

class PermissionHandlerRepositoryImpl implements IPermissionHandlerRepository {
  @override
  Future<Map<Permission, PermissionStatus>> request(List<Permission> permissions) async {
    final Map<Permission, PermissionStatus> statuses = await permissions.request();

    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        throw PermissionHandleException(permission);
      }
    });

    return statuses;
  }
}
