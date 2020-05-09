import 'package:ble_client_app/screens/BottomNavigationScreen.dart';
import 'package:ble_client_app/screens/ConfirmUserScreen.dart';
import 'package:ble_client_app/screens/CreateNewUserScreen.dart';
import 'package:ble_client_app/screens/DeviceScanScreen.dart';
import 'package:ble_client_app/screens/LoginScreen.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case LOGIN_SCREEN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case DEVICE_SCAN_SCREEN:
        return MaterialPageRoute(builder: (_) => DeviceScanScreen());
      case BOTTOM_NAVIGATION_SCREEN:
        return MaterialPageRoute(builder: (_) => BottomNavigationScreen());
      case CONFIRM_USER_SCREEN:
        return MaterialPageRoute(builder: (_) => ConfirmUserScreen(args));
      case NEW_USER_SCREEN:
        return MaterialPageRoute(builder: (_) => CreateNewUserScreen());
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
