import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceStateProvider with ChangeNotifier{

  final BluetoothDevice device;

  DeviceStateProvider({this.device});

  Stream<BluetoothDeviceState> streamDeviceState(){
    if(device != null){
      return connectToDevice();
    }else{
      // scan for the device and try to find it by the device name we have

      // if we find it, connect to it

    }
  }

  Stream<BluetoothDeviceState> connectToDevice(){
    device.connect(timeout: Duration(seconds: 200), autoConnect: false);
    return device.state;
  }
}