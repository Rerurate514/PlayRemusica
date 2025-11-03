import 'package:permission_handler/permission_handler.dart';

class PermissionHandleException implements Exception {
  final Permission permission;
  
  PermissionHandleException(this.permission);

  @override
  String toString() {
    return "PermissionHandleException: Failed to request ${permission.toString()} permission";
  }
}
