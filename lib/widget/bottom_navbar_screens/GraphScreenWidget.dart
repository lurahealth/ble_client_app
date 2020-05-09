import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/graphs/PHGraph.dart';
import 'package:ble_client_app/widget/main_ui_screen_widgets/MainUIScreenButtonRow.dart';
import 'package:ble_client_app/widget/main_ui_screen_widgets/MainUIScreenDailyStatsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphScreenWidget extends StatelessWidget {
  final DeviceDataProvider provider;

  GraphScreenWidget(this.provider);

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
        backgroundColor: LURA_BLUE,
        body: Column(
          children: <Widget>[
            Visibility(
              visible: !provider.fullScreenGraph,
              child: Expanded(
                child: Material(
                  elevation: 18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      pHStaticText,
                      currentPh,
                      dailyStatsWidget,
                      buttonRow,
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  graph,
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.fullscreen,
                          color: LURA_ORANGE,
                        ),
                        onPressed: provider.toggleFullScreenGraph,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
