import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:flutter/material.dart';

class MainUIScreenDailyStatsWidget extends StatelessWidget {

  final DeviceDataProvider provider;

  MainUIScreenDailyStatsWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        dataWidget("Todays Lowest pH", provider.minPh.round()),
        dataWidget("Todays Highest pH", provider.maxPh.round()),
        dataWidget("Todays Average pH", provider.averagePh.round() )
      ],
    );
  }

  Widget dataWidget(String text, int values){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          SizedBox(width: 20,),
          Text(values.toString())
        ],
      ),
    );
  }
}
