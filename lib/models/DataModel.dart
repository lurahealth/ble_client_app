
import 'package:ble_client_app/utils/StringUtils.dart';

class DataModel{
  final num pH;
  final num battery;
  final num temperature;
  final num connectionTime;
  final DateTime timeStamp;
  final String notes;
  final String userName;
  final bool uploaded;

  DataModel(this.pH,
            this.battery,
            this.temperature,
            this.connectionTime,
            this.timeStamp,
            this.notes,
            this.userName,
            this.uploaded);

  Map<String, dynamic> toMap(){
    return {
      PH: pH,
      BATTERY: battery,
      TEMPERATURE: temperature,
      CONNETION_TIME: connectionTime,
      TIME_STAMP: timeStamp.millisecondsSinceEpoch,
      NOTES: notes,
      USER_NAME: userName,
      UPLOADED: uploaded? 1:0 // 1 if uploaded, else 0
    };
  }

  Map<String, dynamic> formatForUpload(){
    return {
      PH: pH,
      BATTERY: battery,
      TEMPERATURE: temperature,
      CONNETION_TIME: connectionTime,
      TIME_STAMP: (timeStamp.millisecondsSinceEpoch/1000).round(),
      NOTES: notes,
      USER_NAME: userName,
      UPLOADED: uploaded? 1:0 // 1 if uploaded, else 0
    };
  }

  String toString(){
    return "TimeStamp: ${timeStamp.toIso8601String()} pH: $pH Voltage: $battery"
           "Temparature: $temperature User name: $userName";
  }

  factory DataModel.fromMap(Map<String, dynamic> map){
    return DataModel(
      map[PH],
      map[BATTERY],
      map[TEMPERATURE],
      map[CONNETION_TIME],
      DateTime.fromMillisecondsSinceEpoch(map[TIME_STAMP]),
      map[NOTES],
      map[USER_NAME],
      (map[UPLOADED] == 1)? true:false
    );
  }

  factory DataModel.fromRawDataString(String data, String notes,
                                      String currentUser, DateTime nowUTC){
    List<String> readings = data.split(",");
    return DataModel(
        double.parse(readings[0]),
        double.parse(readings[2]),
        double.parse(readings[1]),
        (readings.length > 3)? double.parse(readings[3]):null,
        nowUTC,
        notes,
        currentUser,
        true
    );
  }
}