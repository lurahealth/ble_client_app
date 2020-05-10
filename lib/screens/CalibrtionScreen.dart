import 'package:ble_client_app/providers/CalibrationOptionsProvider.dart';
import 'package:ble_client_app/providers/CalibrationProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
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
    final CalibrationProvider provider = Provider.of<CalibrationProvider>(context);
    if(!provider.listening){
      provider.startListening();
    }
    double width = MediaQuery.of(context).size.width;
    final List<Widget> calibrationPoints = getCalibrationWidgets(provider,width);
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
          Expanded(child: ListView.separated(
            itemCount: calibrationPoints.length,
            separatorBuilder: (BuildContext context, int index){
              return SizedBox(height: MediaQuery.of(context).size.height *0.02 ,);
            },
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: calibrationPoints[index],
              );
            },
           ),
          ),
          Visibility(
            visible: provider.allCalibrationComplete,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text("Calibration complete!", style: WHITE_TEXT,),
                      Text("Back to home screen", style: WHITE_TEXT,)
                    ],
                  ),
                ),
                  onPressed: () =>
                      Navigator.pushNamedAndRemoveUntil(context,
                                                        BOTTOM_NAVIGATION_SCREEN,
                                                        (route) => false) ,
              ),
            ),
          )

        ],
      ),
    );
  }

  List<Widget> getCalibrationWidgets(CalibrationProvider provider, double width) {
    List<Widget> calibrationPoints = [];
    int numberOfCalibrationPoints = provider.numberOfCalibrationPoints;
    if (numberOfCalibrationPoints == 1) {
      calibrationPoints.insert(0, calibrationWidget("First", provider, 0, width));
    }

    if (numberOfCalibrationPoints == 2) {
      calibrationPoints.insert(0, calibrationWidget("First", provider, 0, width));
      calibrationPoints.insert(1, calibrationWidget("Second", provider, 1, width));
    }

    if (numberOfCalibrationPoints == 3) {
      calibrationPoints.insert(0, calibrationWidget("First", provider, 0, width));
      calibrationPoints.insert(1, calibrationWidget("Second", provider, 1, width));
      calibrationPoints.insert(2, calibrationWidget("Third", provider, 2, width));
    }

    return calibrationPoints;
  }

  Widget calibrationWidget(String text, CalibrationProvider provider,
                           int currentCalibrationIndex, double width) {
    bool currentCalibration = (currentCalibrationIndex + 1 == provider.currentCalibrationPoint);
    bool calibrationComplete = (currentCalibrationIndex + 1 < provider.currentCalibrationPoint);
    return Material(
      elevation: currentCalibration ? 20 : 10,
      shadowColor: currentCalibration ? LURA_LIGHT_BLUE : Colors.grey,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("$text calibration point", style: LURA_BLUE_TEXT.copyWith(fontSize: 20 )  ,),
                  ),
                  !calibrationComplete
                      ? SizedBox(
                        width: width * 0.1 ,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                            onChanged: provider.calibrationValueEntered,
                          ),
                      )
                      : Text((provider.calibrationValues.length > currentCalibrationIndex)
                             ? provider.calibrationValues[currentCalibrationIndex].toString() : " ")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: calibrationComplete ? Colors.grey : Colors.greenAccent,
                  child: !calibrationComplete
                   ? Text("Record ${text.toLowerCase()} data point")
                   : Text("Calibration complete"),
                  onPressed: !calibrationComplete ?  provider.calibrationButtonPressed : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
