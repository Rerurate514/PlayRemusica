import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionHandlerRepository {
  Future<Map<Permission, PermissionStatus>> request(List<Permission> permissions); 
}
