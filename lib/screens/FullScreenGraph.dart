import 'package:auto_orientation/auto_orientation.dart';
import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/widget/graphs/PHGraph.dart';
import 'package:flutter/material.dart';

class FullScreenGraph extends StatelessWidget {
  final DeviceDataProvider provider;

  FullScreenGraph(this.provider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FittedBox(
        fit: BoxFit.fill,
        child: Stack(
          children: <Widget>[
            Hero(tag: PH_GRAPH, child: PHGraph(provider)),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.fullscreen_exit,
                  color: LURA_ORANGE,
                ),
                onPressed: () {
                  AutoOrientation.portraitAutoMode();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
