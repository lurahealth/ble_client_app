import 'package:auto_orientation/auto_orientation.dart';
import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/graphs/PHGraph.dart';
import 'package:ble_client_app/widget/main_ui_screen_widgets/MainUIScreenButtonRow.dart';
import 'package:ble_client_app/widget/main_ui_screen_widgets/MainUIScreenDailyStatsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class MainUIWidget extends StatelessWidget {
  DeviceDataProvider provider;

  MainUIWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    final Text pHStaticText = Text("Your current pH is");

    final Text currentPh = Text(
      provider.currentPh.toString(),
      style: TextStyle(
          fontSize: 50, fontWeight: FontWeight.w500, color: LURA_BLUE),
    );

    final MainUIScreenDailyStatsWidget dailyStatsWidget =
        MainUIScreenDailyStatsWidget(provider);

    final MainUIScreenButtonRow buttonRow = MainUIScreenButtonRow(provider);

    final PHGraph graph = PHGraph(provider);

    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: pHStaticText),
              Center(child: currentPh),
              dailyStatsWidget,
              buttonRow,
            ],
          ),
        ),
        Stack(
          children: <Widget>[
            graph,
            Align(
              alignment: Alignment.topRight ,
              child: IconButton(
                icon: Icon(
                  Icons.fullscreen,
                  color: LURA_ORANGE,
                ),
                onPressed: () {
                  AutoOrientation.landscapeAutoMode();

                  Navigator.pushNamed(context, FULL_SCREEN_GRAPH,
                      arguments: provider);
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
