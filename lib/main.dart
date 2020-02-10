import 'package:ble_client_app/utils/RouteGenerator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.deepOrangeAccent
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}
