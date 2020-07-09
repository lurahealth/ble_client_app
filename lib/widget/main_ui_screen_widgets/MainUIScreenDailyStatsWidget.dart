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
        dataWidget("Today's Lowest pH", provider.minPh ?? 0),
        dataWidget("Today's Highest pH", provider.maxPh ?? 0),
        dataWidget("Today's Average pH", provider.averagePh ?? 0)
      ],
    );
  }

  Widget dataWidget(String text, double values){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          SizedBox(width: 20,),
          Text(values.toStringAsFixed(2))
        ],
      ),
    );
  }
}
