import 'package:ble_client_app/utils/BluetoothUtils.dart';
import 'package:ble_client_app/utils/SecureStorageUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScanProvider with ChangeNotifier {
  List<ScanResult> scanResults = [];
  FlutterBlue _flutterBlue;
  bool scanning = false; // checks to make sure we only trigger 1 scan when
                         // we load the device scanning screen for the first time
  bool scanningComplete = true; // used to check if we should show or hide
                                // the circular progress bar

  Future<String> scanForDevices() async {
    if (!scanning) {
      scanning = true;
      scanResults = [];
      scanningComplete = false;
      bluetoothScan(onScanResult, onScanningComplete, onErrorScanning);
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
    scanningComplete = true;
    notifyListeners();
  }

  void onScanningComplete(){
    scanningComplete = true;
  }

  void onErrorScanning(error){
    print("Error scanning for devices: ${error.toString()}");
    scanningComplete = true;
  }

  void connectToDevice(BuildContext context, String deviceName) {
    _flutterBlue.stopScan();
    saveBLEDeviceName(deviceName);
    Navigator.pushNamed(context, "/deviceDataScreen", arguments: deviceName);
  }
}
