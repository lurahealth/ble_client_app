import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/singletons/BluetoothSingleton.dart';
import 'package:ble_client_app/widget/bottom_navbar_screens/DataTableScreen.dart';
import 'package:ble_client_app/widget/bottom_navbar_screens/GraphScreenWidget.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final DeviceDataProvider provider = DeviceDataProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => provider,
        ),
        StreamProvider(
          create: (_) => BluetoothSingleton.instance.streamDeviceState() ,
          initialData: BluetoothDeviceState.disconnected,
        ),
      ],
      child: BottomNavigationWidget(),
    );
  }
}

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BluetoothDeviceState deviceState =
        Provider.of<BluetoothDeviceState>(context);
    final DeviceDataProvider provider =
        Provider.of<DeviceDataProvider>(context);
    if (deviceState == BluetoothDeviceState.connected) {
      provider.getData();
    }

    final List<Widget> _widgetOptions = <Widget>[
      GraphScreenWidget(provider),
      DataTableScreen(provider)
    ];

    final AppBar appBar = AppBar(
      // hide the app bar when we have a full screen graph
      backgroundColor: LURA_BLUE,
      title: SizedBox(
          height: 30,
          child: Image.asset("images/title_logo.png"),
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onLongPress: null,
            child: Icon(
              Icons.bluetooth,
              color: (deviceState == BluetoothDeviceState.connected)
                  ? Colors.lightGreenAccent // if connected to device, show green
                  : Colors.red, // else show red
            ),
          ),
        )
      ],
    );

    final BottomNavigationBar bottomNavigationBar =  BottomNavigationBar(
      backgroundColor: LURA_BLUE,
      currentIndex: provider.currentScreen,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.timeline),
          ),
          title: Text('Main UI'),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.table_chart),
          ),
          title: Text('Data Table'),
        ),
      ],
      selectedItemColor: LURA_ORANGE,
      unselectedItemColor: Colors.white,
      onTap: (value) => provider.onBottomNavigationBarTapped(value),
    );

    return Scaffold(
      appBar: provider.fullScreenGraph ? null : appBar,
      body: Center(
        child: _widgetOptions.elementAt(provider.currentScreen),
      ),
      bottomNavigationBar: provider.fullScreenGraph ? null : bottomNavigationBar
    );
  }
}
