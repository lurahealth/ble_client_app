
import 'package:ble_client_app/utils/StringUtils.dart';

class DataModel{
  final num pH;
  final num battery;
  final num temperature;
  final num connectionTime;
  final DateTime timeStamp;
  final String notes;
  final String deviceId;
  final bool uploaded;

  DataModel(this.pH,
            this.battery,
            this.temperature,
            this.connectionTime,
            this.timeStamp,
            this.notes,
            this.deviceId,
            {this.uploaded});

  Map<String, dynamic> toMap(){
    return {
      PH: pH,
      BATTERY: battery,
      TEMPERATURE: temperature,
      CONNETION_TIME: connectionTime,
      TIME_STAMP: timeStamp.millisecondsSinceEpoch,
      NOTES: notes,
      DEVICE_ID: deviceId,
      UPLOADED: uploaded? 1:0 // 1 if uploaded, else 0
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map){
    return DataModel(
      map[PH],
      map[BATTERY],
      map[TEMPERATURE],
      map[CONNETION_TIME],
      DateTime.fromMillisecondsSinceEpoch(map[TIME_STAMP]),
      map[NOTES],
      map[DEVICE_ID],
      uploaded: (map[UPLOADED] == 1)? true:false
    );
  }
}