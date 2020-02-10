import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/graphs/MainUIScreenGraph.dart';
import 'package:ble_client_app/widget/main_ui_screen_widgets/MainUIScreenButtonRow.dart';
import 'package:ble_client_app/widget/main_ui_screen_widgets/MainUIScreenDailyStatsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class MainUIScreen extends StatelessWidget {
  final BluetoothDevice device;

  MainUIScreen({this.device});

  @override
  Widget build(BuildContext context) {
    DeviceDataProvider provider;
    if (device != null) {
      provider = DeviceDataProvider(device: device);
    } else {
      provider = DeviceDataProvider();
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => provider,
        ),
        StreamProvider(
          create: (_) => provider.streamDeviceState(),
          initialData: BluetoothDeviceState.disconnected,
        ),
      ],
      child: MainUIWidget(),
    );
  }
}

class MainUIWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final BluetoothDeviceState deviceState =
        Provider.of<BluetoothDeviceState>(context);
    final DeviceDataProvider provider =
        Provider.of<DeviceDataProvider>(context);
    if (deviceState == BluetoothDeviceState.connected) {
      provider.getData();
    }

    final Text pHStaticText = Text(
        "Your current pH is"
    );

    final Text currentPh = Text(
        provider.currentPh.toString(),
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w500,
        color: LURA_BLUE
      ),
    );

    final MainUIScreenDailyStatsWidget dailyStatsWidget = MainUIScreenDailyStatsWidget(provider);

    final MainUIScreenButtonRow buttonRow = MainUIScreenButtonRow(provider);

    final MainUIScreenGraph graph = MainUIScreenGraph(provider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: LURA_BLUE,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.bluetooth,
              color: (deviceState == BluetoothDeviceState.connected)
                  ? Colors
                      .lightGreenAccent // if connected to device, show green
                  : Colors.red, // else show red
            ),
          )
        ],
      ),
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
          Expanded(
              child: graph
          ),
        ],
      )
    );
  }
}
