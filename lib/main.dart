import 'package:ble_client_app/utils/RouteGenerator.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: LURA_BLUE,
            accentColor: LURA_ORANGE
        ),
        initialRoute: DEVICE_SCAN_SCREEN,
        onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}
