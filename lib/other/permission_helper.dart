import 'dart:ffi';

import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<void> requestPermission([List<Permission> permissions = const []]) async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      //Permission.location,
      Permission.storage,
    ].request();
  }
}
