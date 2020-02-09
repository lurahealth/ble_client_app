import 'package:ble_client_app/utils/BluetoothUtils.dart';
import 'package:ble_client_app/utils/SecureStorageUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScanProvider with ChangeNotifier {
  List<ScanResult> scanResults = [];
  FlutterBlue _flutterBlue;
  bool scanning = false; // checks to make sure we only trigger 1 scan when
                         // we load the device scanning screen for the first time

  Future<String> scanForDevices() async {
    if (!scanning) {
      scanning = true;
      scanResults = [];
      bluetoothScan(onScanResult);
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

  void connectToDevice(BuildContext context, String deviceName) {
    _flutterBlue.stopScan();
    saveBLEDeviceName(deviceName);
    Navigator.pushNamed(context, "/deviceDataScreen", arguments: deviceName);
  }
}
