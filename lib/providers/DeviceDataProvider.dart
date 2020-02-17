import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:ble_client_app/models/DataModel.dart';
import 'package:ble_client_app/models/AreaChartData.dart';
import 'package:ble_client_app/singletons/BluetoothUtils.dart';
import 'package:ble_client_app/singletons/DatabaseProvider.dart';
import 'package:ble_client_app/utils/RestEndpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceDataProvider with ChangeNotifier {
  final BluetoothDevice device;
  DeviceDataProvider(this.device);

  String deviceName;
  bool receivingData = false;
  String notes;
  int width = 20; // seconds
  static DateTime currentTime = DateTime.now();
  DateTime min = currentTime;
  DateTime max = currentTime.add(Duration(seconds: 20));
  double animationDuration = 0;
  int currentScreen = 0;
  bool fullScreenGraph = false;
  Icon graphIcon = Icon(Icons.fullscreen);

  List<DataModel> allData = <DataModel>[];
  List<AreaChartData> pHData = <AreaChartData>[];

  String connectDisconnectButtonText = "Connecting";
  StreamSubscription<List<int>> bluetoothDataSubscription;
  BluetoothCharacteristic rx;

  double currentPh = 0;
  double minPh = 0;
  double maxPh = 0;
  double averagePh = 0;

  static const int PAST_DATA_SMALL_GRAPH = 16; // 4 readings per hours, 4 hours of data


  Stream<BluetoothDeviceState> streamDeviceState() {
    deviceName = device.name;
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
//      if(averagePh == 0){
//        await getDailyStatsFromDB();
//        await getPastDataFromDB();
//      }

      connectDisconnectButtonText = "Disconnect";
      notifyListeners();
      print("getting data");

      rx = await getRx(device);

      bluetoothDataSubscription = rx.value.listen(onDataReceived,
          onError: onErrorReceivingData, onDone: onDoneCalled);

      rx.setNotifyValue(true);
    }
  }

  Future<void> getPastDataFromDB() async{
    List<Map<String, dynamic>> queryResult = await DatabaseProvider.db
                                          .getLastNRows(PAST_DATA_SMALL_GRAPH);
    queryResult.forEach((row){
      DataModel dataModel = DataModel.fromMap(row);
      allData.insert(0, dataModel);
      pHData.add(AreaChartData.fromLiveData(dataModel.timeStamp.toLocal(), dataModel.pH));
    });
  }

  Future<void> getDailyStatsFromDB() async {
    final DateTime nowLocal = DateTime.now();
    final lastMidnight = new DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
    List<Map<String, dynamic>> queryResult = await DatabaseProvider.db
        .getDailyStatsByDeviceName(
        lastMidnight.millisecondsSinceEpoch, nowLocal.millisecondsSinceEpoch, deviceName);
    Map<String, dynamic> statsMap = queryResult[0];
    averagePh = statsMap["average"];
    minPh = statsMap["min"];
    maxPh = statsMap["max"];
    print("Average ph: $averagePh min pH: $minPh max ph: $maxPh");
  }

  void onDataReceived(List<int> value) {
    final DateTime nowLocal = DateTime.now();
    final DateTime nowUTC = nowLocal.toUtc();
    final String data = utf8.decode(value);
//    print("Raw Data $value");
    if (data.contains(",")) {
      final DataModel dataModel =
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
      max = nowLocal.subtract(Duration(seconds: 16));
      min = nowLocal.add(Duration(seconds: 8));
    }
  }

  void saveDataInLocalDatabase(DataModel dataModel) {
    DatabaseProvider.db.insertSensorData(dataModel);
  }

  void displayData(DataModel dataModel, DateTime nowLocal) {
    allData.insert(0, dataModel);
    pHData.add(AreaChartData.fromLiveData(nowLocal, dataModel.pH));
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

  void onBottomNavigationBarTapped(int value) {
//    print("Tapped $value");
    currentScreen = value;
    notifyListeners();
  }

  void toggleFullScreenGraph() {
    if(fullScreenGraph){
      fullScreenGraph = false;
      AutoOrientation.portraitAutoMode();
      graphIcon = Icon(Icons.fullscreen);
    }else{
      fullScreenGraph = true;
      AutoOrientation.landscapeAutoMode();
      graphIcon = Icon(Icons.fullscreen_exit);
    }
    notifyListeners();
  }
}
