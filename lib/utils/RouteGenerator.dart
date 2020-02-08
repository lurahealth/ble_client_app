import 'package:ble_client_app/screens/DeviceScanScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DeviceScanScreen());
      default:
        return _errorRoute();
    }
  }



  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}