//import 'package:ble_client_app/utils/LocationPermissionUtils.dart';
//import 'package:ble_client_app/utils/StringUtils.dart';
//import 'package:flutter_blue/flutter_blue.dart';
//import 'package:permission_handler/permission_handler.dart';
//
//Future<BluetoothCharacteristic> getRx(BluetoothDevice device) async {
//  List<BluetoothService> services = await device.discoverServices();
//  BluetoothService uartService = getUartService(services);
//  List<BluetoothCharacteristic> characteristics = uartService.characteristics;
//  return getRxCharacteristic(characteristics);
//}
//
//BluetoothService getUartService(List<BluetoothService> services) {
//   return services
//      .firstWhere((services) => services.uuid.toString() == UART_SERVICE_UUID);
//}
//
//BluetoothCharacteristic getRxCharacteristic(
//    List<BluetoothCharacteristic> characteristics) {
//  return characteristics.firstWhere((c) => c.uuid.toString() == RX_UUID);
//}
//
//class BluetoothProvider {
//  static FlutterBlue _flutterBlue;
//  static final BluetoothProvider provider = BluetoothProvider._();
//
//  BluetoothProvider._();
//
//  FlutterBlue get flutterBlue {
//    if (_flutterBlue != null)
//      return _flutterBlue;
//    else {
//      _flutterBlue = FlutterBlue.instance;
//      return _flutterBlue;
//    }
//  }
//
//  Future<void> bluetoothScan(Function onScanResult, Function onScanComplete,
//      Function onErrorScanning) async {
//    print("Scanning for devices");
//    if (await checkLocationPermission(PermissionGroup.locationAlways)) {
//      flutterBlue.startScan(timeout: Duration(seconds: 5));
//      flutterBlue.scanResults.listen(onScanResult,
//          onDone: onScanComplete,
//          onError: onErrorScanning,
//          cancelOnError: true);
//    } else {
//      print("No Location permission");
//    }
//  }
//
//  Future stopScan() async {
//    await flutterBlue.stopScan();
//  }
//}
