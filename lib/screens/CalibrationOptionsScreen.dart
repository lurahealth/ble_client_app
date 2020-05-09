import 'package:ble_client_app/providers/CalibrationOptionsProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalibrationOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => CalibrationOptionsProvider(),
      child: CalibrationOptionsWidget(),
    );
  }
}

class CalibrationOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalibrationOptionsProvider provider = Provider.of<CalibrationOptionsProvider>(context);
    if(!provider.listening){
      provider.startListening();
    }
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
          Visibility(
            visible: !provider.loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Center(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getCalibrationButton(ONE_POINT_CALIBRATION, context, provider),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getCalibrationButton(TWO_POINT_CALIBRATION, context, provider),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getCalibrationButton(THREE_POINT_CALIBRATION, context, provider),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: RaisedButton(
                      color: LIGHT_GREEN,
                      onPressed: provider.startCalibration,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Start Calibration", style: WHITE_TEXT.copyWith(fontSize: 20),),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: provider.loading ,
            child: LoadingWidget("Waiting for calibration to start", LURA_BLUE))
        ],
      ),
    );
  }

  AnimatedContainer getCalibrationButton(String text, BuildContext context,
                                CalibrationOptionsProvider provider){
    bool selected = (text == provider.selectedCalibrationOption);
    double width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child : Material(
        borderRadius: BorderRadius.circular(32),
        elevation: selected ? 30 : 0,
        child: MaterialButton(
            minWidth: selected ?  width : width*0.9,
            color: selected ? LURA_BLUE : LURA_LIGHT_BLUE,
            onPressed:()=> provider.calibrationButtonPressed(text),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(text, style: WHITE_TEXT.copyWith(fontSize: 20),),
          ),
        ),
      ),
    );
  }
}

