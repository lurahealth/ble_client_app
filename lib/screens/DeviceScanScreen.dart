import 'package:ble_client_app/providers/DevicesScanProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/LoadingWidget.dart';
import 'package:ble_client_app/widget/device_scan_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class DeviceScanScreen extends StatelessWidget {

  final provider = DeviceScanProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => provider),
      StreamProvider(create:(_) => provider.checkBluetooth(), initialData: false,)
    ],
    child: DeviceScanWidget(),);


//    return ChangeNotifierProvider<DeviceScanProvider>(
//      create: (_) => DeviceScanProvider(),
//      child: DeviceScanWidget(),
//    );
  }
}

class DeviceScanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeviceScanProvider>(context);
    final isBluetoothEnabled = Provider.of<bool>(context);
    if(isBluetoothEnabled){
      provider.scanForDevices();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LURA_BLUE,
        title: new Text("Device scan"),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          provider.scanning = false; // set to false so we can scan again
          provider.scanForDevices();
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              Visibility(
                visible: (provider.scanningComplete ||
                          provider.scanResults.length> 0),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(thickness: 1.5),
                    itemCount: provider.scanResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      ScanResult result = provider.scanResults[index];
                      return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: DeviceScanListItem(result, provider)
                      );
                    }),
              ),
              Visibility(
                  visible: !provider.scanningComplete && isBluetoothEnabled,
                  child: LoadingWidget("Scanning for devices", LURA_BLUE)
              ),
              Visibility(
                visible: !isBluetoothEnabled,
                child: Text(
                  "Bluetooth disabled!",
                  style: ERROR_TEXT.copyWith(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
