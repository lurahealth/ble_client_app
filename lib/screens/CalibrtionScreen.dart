import 'package:ble_client_app/providers/CalibrationOptionsProvider.dart';
import 'package:ble_client_app/providers/CalibrationProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalibrationScreen extends StatelessWidget {
  final String calibrationType;

  CalibrationScreen(this.calibrationType);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalibrationProvider(calibrationType),
      child: CalibrationWidget(),
    );
  }
}

class CalibrationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalibrationProvider provider =
        Provider.of<CalibrationProvider>(context);
    final List<Widget> calibrationPoints = getCalibrationWidgets(provider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LURA_BLUE,
        title: SizedBox(
          height: 30,
          child: Image.asset("images/title_logo.png"),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ListView(children: calibrationPoints,)),

        ],
      ),
    );
  }

  List<Widget> getCalibrationWidgets(CalibrationProvider provider) {
    List<Widget> calibrationPoints = [];
    int numberOfCalibrationPoints = provider.numberOfCalibrationPoints;
    if (numberOfCalibrationPoints > 0) {
      calibrationPoints.insert(0, calibrationWidget("First", provider, 0));
    }

    if (numberOfCalibrationPoints > 1) {
      calibrationPoints.insert(1, calibrationWidget("Second", provider, 0));
    }

    if (numberOfCalibrationPoints > 2) {
      calibrationPoints.insert(2, calibrationWidget("Second", provider, 0));
    }

    return calibrationPoints;
  }

  Widget calibrationWidget(
      String text, CalibrationProvider provider, int currentCalibrationIndex) {
    bool currentCalibration =
        (currentCalibrationIndex + 1 == provider.calibrationValues.length);
    bool calibrationComplete =
        (currentCalibrationIndex + 1 > provider.calibrationValues.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: currentCalibration ? 30 : 0,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text(text),
                    calibrationComplete
                        ? TextField(
                            onChanged: (value) =>
                                provider.calibrationValueEntered(
                                    value, currentCalibrationIndex),
                          )
                        : Text(
                            provider.calibrationValues[currentCalibrationIndex])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    onPressed: () => provider
                        .calibrationButtonPressed(currentCalibrationIndex)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
