import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceStateProvider with ChangeNotifier{
  final BluetoothDevice device;

  DeviceStateProvider(this.device);

  Stream<BluetoothDeviceState> connectToDevice(){
    device.connect(timeout: Duration(seconds: 200), autoConnect: false);
    return device.state;
  }
}