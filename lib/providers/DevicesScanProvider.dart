import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show File, Platform, sleep;

class DeviceScanProvider with ChangeNotifier {
  List<ScanResult> scanResults = [];
  PermissionHandler _permissionHandler;
  FlutterBlue _flutterBlue;

  Future<String> scanForDevices() async {
    print("Scanning for devices");
    bool locationPermissions = await permissionCheck(PermissionGroup.locationAlways);
    print(locationPermissions);
    if (locationPermissions) {
      scanResults = [];
      if (_flutterBlue == null) {
        _flutterBlue = FlutterBlue.instance;
      } else {
        _flutterBlue.stopScan();
      }
      // Start scanning
      _flutterBlue.startScan(timeout: Duration(seconds: 10));
      _flutterBlue.scanResults.listen(onScanResult);
    } else {
      print("No Location permission");
    }

    return "Return";
  }

  void onScanResult(List<ScanResult> scanResults) {
    scanResults.forEach((result){
      String name = result.device.name;
//      print(name);
      if(name != null &&
         name.length > 0 &&
         !(this.scanResults.contains(result))){
        this.scanResults.add(result);
      }
    });
    notifyListeners();
  }

  Future<bool> permissionCheck(PermissionGroup permission) async {
    if (_permissionHandler == null) {
      _permissionHandler = PermissionHandler();
    }

    // check for location permission
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    if (permissionStatus != PermissionStatus.granted) {
      var result = await _permissionHandler.requestPermissions([permission]);
      if (result[permission] == PermissionStatus.granted) {
        return true;
      } else
        return false;
    } else {
      return true;
    }
  }

  void connectToDevice(BuildContext context, BluetoothDevice device) {
    _flutterBlue.stopScan();
//    if (Platform.isAndroid) {
//      sleep(const Duration(seconds: 1));
//    }
    Navigator.pushNamed(context, "/deviceDataScreen", arguments: device);
  }
}
