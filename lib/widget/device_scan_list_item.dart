import 'package:ble_client_app/providers/DevicesScanProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScanListItem extends StatelessWidget {
  final ScanResult scanResult;
  final DeviceScanProvider provider;

  DeviceScanListItem(this.scanResult, this.provider);

  @override
  Widget build(BuildContext context) {
    BluetoothDevice device = scanResult.device;
    return GestureDetector(
      onTap: () => provider.connectToDevice(context, device),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text("RSSI ${scanResult.rssi}"),
          new Text("Name: ${device.name}"),
          new Text(device.type.toString())
        ],
      ),
    );
  }
}
