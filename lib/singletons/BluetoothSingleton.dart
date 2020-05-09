import 'package:ble_client_app/utils/LocationPermissionUtils.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothSingleton{
  static FlutterBlue _flutterBlue;
  BluetoothDevice _connectedDevice;

  BluetoothSingleton._privateConstructor();

  static final BluetoothSingleton _instance = BluetoothSingleton._privateConstructor();

  static BluetoothSingleton get instance {return _instance;}

  BluetoothDevice get connectedDevice => _connectedDevice;

  set connectedDevice(BluetoothDevice value) {
    _connectedDevice = value;
  }

  FlutterBlue get flutterBlue {
    if (_flutterBlue != null)
      return _flutterBlue;
    else {
      _flutterBlue = FlutterBlue.instance;
      return _flutterBlue;
    }
  }

  Future<void> bluetoothScan(Function onScanResult, Function onScanComplete,
      Function onErrorScanning) async {
    print("Scanning for devices");
    if (await checkLocationPermission(PermissionGroup.locationAlways)) {
      flutterBlue.startScan(timeout: Duration(seconds: 5));
      flutterBlue.scanResults.listen(onScanResult,
          onDone: onScanComplete,
          onError: onErrorScanning,
          cancelOnError: true);
    } else {
      print("No Location permission");
    }
  }

  Future stopScan() async {
    await flutterBlue.stopScan();
  }

  Stream<BluetoothDeviceState> streamDeviceState() {
    _connectedDevice.connect(timeout: Duration(seconds: 200), autoConnect: false);
    return _connectedDevice.state;
  }

  Future connect({Duration timeout = const Duration(seconds: 10),
                  bool autoConnect = false}) async {
    await _connectedDevice.connect(timeout: timeout, autoConnect: autoConnect);
  }


  Future disconnect() async {
    return await _connectedDevice.disconnect();
  }

  Future<BluetoothCharacteristic> getRx() async {
    List<BluetoothService> services = await _connectedDevice.discoverServices();
    BluetoothService uartService = getUartService(services);
    List<BluetoothCharacteristic> characteristics = uartService.characteristics;
    return getRxCharacteristic(characteristics);
  }

  BluetoothService getUartService(List<BluetoothService> services) {
    return services
        .firstWhere((services) => services.uuid.toString() == UART_SERVICE_UUID);
  }

  BluetoothCharacteristic getRxCharacteristic(
      List<BluetoothCharacteristic> characteristics) {
    return characteristics.firstWhere((c) => c.uuid.toString() == RX_UUID);
  }


}