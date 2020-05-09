import 'dart:async';
import 'dart:convert';

import 'package:ble_client_app/singletons/BluetoothSingleton.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class CalibrationOptionsProvider with ChangeNotifier{
  String selectedCalibrationOption;
  String calibrationMessage;
  StreamSubscription<List<int>> bluetoothDataSubscription;
  bool listening = false;
  bool loading = false;

  Future<void> startListening() async {
    if(!listening){
      listening = true;
      BluetoothCharacteristic rx = await BluetoothSingleton.instance.getRx();
      bluetoothDataSubscription = rx.value.listen(onDataReceived,
          onError: onErrorReceivingData);

      rx.setNotifyValue(true);
    }
  }

  void calibrationButtonPressed(String calibration){
    selectedCalibrationOption = calibration;
    switch (selectedCalibrationOption){
      case ONE_POINT_CALIBRATION:
        calibrationMessage = "STARTCAL1";
        break;
      case TWO_POINT_CALIBRATION:
        calibrationMessage = "STARTCAL2";
        break;
      case THREE_POINT_CALIBRATION:
        calibrationMessage = "STARTCAL3";
        break;

    }
    notifyListeners();
  }

  Future<void> startCalibration() async {
    if (selectedCalibrationOption != null) {
      print("Start calibration");
      loading = true;
      notifyListeners();

      BluetoothCharacteristic tx = await BluetoothSingleton.instance.getTx();

      print("Sending message $calibrationMessage");
      await tx.write(utf8.encode(calibrationMessage));
    }
  }

  void onDataReceived(List<int> value){
    print("Raw data received ${value.toString()}");
    String parsedData = utf8.decode(value);
    print("Parsed data: $parsedData");
    if(parsedData == "CALBEGIN"){

    }else{
      loading = false;
      notifyListeners();
    }
  }

  onErrorReceivingData(error) {
    print("Error receiving data: $error");
    notifyListeners();
    bluetoothDataSubscription.cancel();
  }
}