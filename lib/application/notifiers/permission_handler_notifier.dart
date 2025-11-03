import 'package:permission_handler/permission_handler.dart';
import 'package:playremusica/domain/repositories/permission_handler_repository_interface.dart';
import 'package:playremusica/infrastructure/repositories/permission_handler_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_handler_notifier.g.dart';

@riverpod
class PermissionHandlerNotifier extends _$PermissionHandlerNotifier {
  late final IPermissionHandlerRepository _phr;
  
  @override
  void build() {
    _phr = ref.read(permissionHandlerRepositoryProvider);
  }

  Future<Map<Permission, PermissionStatus>> request(List<Permission> permissions) async {
    return await _phr.request(permissions);
  }
}
