import 'package:ble_client_app/models/DataModel.dart';
import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/material.dart';

import '../ColumnHeaderWidget.dart';

class DataTableScreen extends StatelessWidget {
  final DeviceDataProvider provider;

  DataTableScreen(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ColumnHeaderWidget(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: provider.allData.length,
            itemBuilder: (BuildContext context, int index) {
              DataModel dataModel = provider.allData[index];
              return Container(
                color: index.isEven ? Colors.grey[350] : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getText(
                          dataTableTimeFormat.format(dataModel.timeStamp.toLocal())),
                      getText(dataModel.pH.toString()),
                      getText(dataModel.pHMilliVolts.toString()),
                      getText(dataModel.temperature.toString()),
                      getText(dataModel.battery.toString())
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Text getText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 15)
    );
  }
}
