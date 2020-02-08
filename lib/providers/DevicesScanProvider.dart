import 'package:ble_client_app/utils/SecureStorageUtils.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceScanProvider with ChangeNotifier {
  List<ScanResult> scanResults = [];
  PermissionHandler _permissionHandler;
  FlutterBlue _flutterBlue;
  bool scanning = false; // checks to make sure we only trigger 1 scan when
                         // we load the device scanning screen for the first time

  Future<String> scanForDevices() async {
    if (!scanning) {
      scanning = true;
      print("Scanning for devices");
      bool locationPermissions =
          await permissionCheck(PermissionGroup.locationAlways);
      if (locationPermissions) {
        scanResults = [];
        if (_flutterBlue == null) {
          _flutterBlue = FlutterBlue.instance;
        } else {
          _flutterBlue.stopScan();
        }
        _flutterBlue.startScan(timeout: Duration(seconds: 10));
        _flutterBlue.scanResults.listen(onScanResult);
      } else {
        print("No Location permission");
      }
    }

    return "Return";
  }

  void onScanResult(List<ScanResult> scanResults) {
    scanResults.forEach((result) {
      String name = result.device.name;
      if (name != null &&
          name.length > 0 &&
          !(this.scanResults.contains(result))) {
        this.scanResults.add(result);
      }
    });
    notifyListeners();
  }

  Future<bool> permissionCheck(PermissionGroup permission) async {
    if (_permissionHandler == null) {
      _permissionHandler = PermissionHandler();
    }

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
    SecureStorageUtils.writeToSecureStorage(StringUtils.BLE_DEVICE_NAME,
                                            device.name);
    Navigator.pushNamed(context, "/deviceDataScreen", arguments: device);
  }
}
