import 'package:permission_handler/permission_handler.dart';

PermissionHandler _permissionHandler;

Future<bool> checkLocationPermission(PermissionGroup permission) async {
  if (_permissionHandler == null) {
    _permissionHandler = PermissionHandler();
  }
  var permissionStatus =
  await _permissionHandler.checkPermissionStatus(permission);
  if (permissionStatus == PermissionStatus.granted) {
    return true;
  } else {
    return getLocationPermission(permission);
  }
}

Future<bool> getLocationPermission(PermissionGroup permission) async {
  var result = await _permissionHandler.requestPermissions([permission]);
  if (result[permission] == PermissionStatus.granted)
    return true;
  else
    return false;
}