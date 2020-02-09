import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

FlutterBlue _flutterBlue;
PermissionHandler _permissionHandler;

Future<void> bluetoothScan(Function onScanResult,
                           Function onScanComplete,
                           Function onErrorScanning) async {
  print("Scanning for devices");
  if (await checkLocationPermission(PermissionGroup.locationAlways)) {
    if (_flutterBlue == null) {
      _flutterBlue = FlutterBlue.instance;
    } else {
      _flutterBlue.stopScan();
    }
    _flutterBlue.startScan(timeout: Duration(seconds: 5));
    _flutterBlue.scanResults.listen(onScanResult,
                                    onDone: onScanComplete,
                                    onError: onErrorScanning,
                                    cancelOnError: true);
  } else {
    print("No Location permission");
  }
}

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
