import 'dart:async';
import 'dart:convert';

import 'package:ble_client_app/models/DataModel.dart';
import 'package:ble_client_app/models/SplineData.dart';
import 'package:ble_client_app/singletons/BluetoothUtils.dart';
import 'package:ble_client_app/singletons/DatabaseProvider.dart';
import 'package:ble_client_app/utils/RestEndpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceDataProvider with ChangeNotifier {
  final BluetoothDevice device;
  String deviceName;

  DeviceDataProvider({this.device});

  bool receivingData = false;
  String notes;
  int width = 20; // seconds
  static DateTime currentTime = DateTime.now();
  DateTime min = currentTime;
  DateTime max = currentTime.add(Duration(seconds: 20));
  double animationDuration = 0;

  List<DataModel> allData = <DataModel>[];
  List<SplineData> pHData = <SplineData>[];

  String connectDisconnectButtonText = "Connecting";
  StreamSubscription<List<int>> bluetoothDataSubscription;
  BluetoothCharacteristic rx;

  double currentPh = 0;
  double minPh = 10000;
  double maxPh = 0;
  double averagePh = 0;



  Stream<BluetoothDeviceState> streamDeviceState() {
    if (device != null) {
      deviceName = device.name;
      return connectToDevice();
    } else {
      // scan for the device and try to find it by the device name we have

      // if we find it, set the device name

      // and then connection to it.

    }
  }

  Stream<BluetoothDeviceState> connectToDevice() {
    device.connect(timeout: Duration(seconds: 200), autoConnect: false);
    return device.state;
  }

  Future<void> disconnectFromDevice() async {
    rx.setNotifyValue(false);
    await device.disconnect();
    bluetoothDataSubscription.cancel();
    receivingData = false;
    connectDisconnectButtonText = "Connect";
    notifyListeners();
  }

  Future<void> getData() async {
    if (!receivingData) {
      receivingData = true;
      connectDisconnectButtonText = "Disconnect";
      notifyListeners();
      print("getting data");

      rx = await getRx(device);

      bluetoothDataSubscription = rx.value.listen(onDataReceived,
          onError: onErrorReceivingData, onDone: onDoneCalled);

      rx.setNotifyValue(true);
    }
  }

  void onDataReceived(List<int> value) {
    DateTime nowLocal = DateTime.now();
    DateTime nowUTC = nowLocal.toUtc();
    String data = utf8.decode(value);
//    print("Raw Data $value");
    if (data.contains(",")) {
      DataModel dataModel =
          DataModel.fromRawDataString(data, notes, deviceName, nowUTC);
//      print(dataModel.toString());
      saveDataInLocalDatabase(dataModel);
      displayData(dataModel, nowLocal);
      uploadData(dataModel);
      calculateMixMaxTimes(nowLocal);

      if (notes != null) {
        print(notes);
        notes = null;
      }
      notifyListeners();
    } else {
      print("Invalid data: $data");
    }
  }

  void calculateMixMaxTimes(DateTime nowLocal) {
    if (allData.length <= width) {
      if (allData.length == 0) {
        min = nowLocal;
        max = min.add(Duration(seconds: width));
      } else {
        min = allData.last.timeStamp.toLocal();
        max = min.add(Duration(seconds: width));
      }
    } else {
      max = allData.first.timeStamp.toLocal();
      min = max.subtract(Duration(seconds: width));
    }
  }

  void saveDataInLocalDatabase(DataModel dataModel) {
    DatabaseProvider.db.insertSensorData(dataModel);
  }

  void displayData(DataModel dataModel, DateTime nowLocal) {
    allData.insert(0, dataModel);
    pHData.add(SplineData.fromLiveData(nowLocal, dataModel.pH));
    calculateMinMaxAndAveragePH(dataModel.pH);
  }

  calculateMinMaxAndAveragePH(double currentPh){
    this.currentPh = currentPh;
    if(currentPh > maxPh){
      maxPh = currentPh;
    }

    if(currentPh < minPh){
      minPh = currentPh;
    }
    averagePh = calculateNewAverage();
  }

  double calculateNewAverage(){
    int currentDataLength = allData.length;
    double oldTotal = averagePh * (currentDataLength -1);
    double newTotal = oldTotal + currentPh;
    return newTotal/currentDataLength;
  }

  void uploadData(DataModel dataModel) {
    RestEndpoints.uploadData(dataModel);
  }

  onErrorReceivingData(error) {
    print("Error receiving data: $error");
    notifyListeners();
    bluetoothDataSubscription.cancel();
  }

  void onDoneCalled() {
    print("on done called");
    disconnectFromDevice();
  }

  void saveNote(String note) {
    this.notes = note;
  }

  Future<void> connectDisconnectFromDevice() async {
    if(receivingData) {
      await disconnectFromDevice();
    }else{
      print("Trying to connect");
      await device.connect(timeout: Duration(seconds: 10), autoConnect: false);
    }
  }
}
