import 'package:ble_client_app/singletons/BluetoothSingleton.dart';
import 'package:ble_client_app/utils/BluetoothUtils.dart';
import 'package:ble_client_app/singletons/SecureStorageUtils.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScanProvider with ChangeNotifier {
  List<ScanResult> scanResults = [];
  bool scanning = false; // checks to make sure we only trigger 1 scan when
                         // we load the device scanning screen for the first time
  bool scanningComplete = false; // used to check if we should show or hide
                                // the circular progress bar

  bool bluetoothOn = false;

  Stream<bool> checkBluetooth() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    return  flutterBlue.isOn.asStream();
  }

  Future<String> scanForDevices() async {
    if (!scanning) {
      scanning = true;
      scanResults = [];
      scanningComplete = false;
      BluetoothSingleton.instance
                        .bluetoothScan(onScanResult, onScanningComplete, onErrorScanning);
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

  void connectToDevice(BuildContext context, BluetoothDevice device) {
    //BluetoothProvider.provider.stopScan();
    BluetoothSingleton.instance.stopScan();
//    saveBLEDeviceName(device.name);
    BluetoothSingleton.instance.connectedDevice = device;
    Navigator.pushReplacementNamed(context, BOTTOM_NAVIGATION_SCREEN);
  }
}
