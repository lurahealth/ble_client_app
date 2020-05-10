import 'dart:async';
import 'dart:convert';

import 'package:ble_client_app/singletons/BluetoothSingleton.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class CalibrationProvider with ChangeNotifier{

  CalibrationProvider(String calibration){
    switch (calibration) {
      case ONE_POINT_CALIBRATION:
        numberOfCalibrationPoints = 1;
        break;
      case TWO_POINT_CALIBRATION:
        numberOfCalibrationPoints = 2;
        break;
      case THREE_POINT_CALIBRATION:
        numberOfCalibrationPoints = 3;
        break;
    }
  }


  int numberOfCalibrationPoints = 0;
  List<String> calibrationValues = [];
  String currentCalibrationValue;
  bool listening = false;
  bool loading = false;
  String loadingMessage;
  StreamSubscription<List<int>> bluetoothDataSubscription;

  Future<void> startListening() async {
    if(!listening){
      listening = true;
      BluetoothCharacteristic rx = await BluetoothSingleton.instance.getRx();
      bluetoothDataSubscription = rx.value.listen(onDataReceived,
          onError: onErrorReceivingData);

      rx.setNotifyValue(true);
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

  void calibrationValueEntered(String value, int currentCalibrationIndex) {
    calibrationValues.insert(currentCalibrationIndex, value);
    currentCalibrationValue = value;
  }

  void calibrationButtonPressed(int currentCalibrationIndex) {
    print(calibrationValues[currentCalibrationIndex]);
  }
}