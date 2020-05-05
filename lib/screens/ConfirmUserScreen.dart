import 'package:ble_client_app/models/LoginDetails.dart';
import 'package:ble_client_app/providers/ConfirmUserScreenProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmUserScreen extends StatelessWidget {
  final LoginDetails _loginDetails;

  ConfirmUserScreen(this._loginDetails);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmUserScreenProvider(_loginDetails),
      child: ConfirmUserWidget(),
    );
  }
}

class ConfirmUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConfirmUserScreenProvider provider =
        Provider.of<ConfirmUserScreenProvider>(context);

    final titleText = Text(
      "Please enter the 6 digit code sent to your email address",
      textAlign: TextAlign.center,
    );

    final confirmCodeTextField = TextField(
      onChanged: provider.checkConfirmationCode,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
    );

    final errorMessage = Text(provider.errorMessage, style: ERROR_TEXT,);

    final confirmButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: LURA_BLUE,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed:() => provider.sendConfirmCode(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Send confirm code",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: !provider.loading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: titleText,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: confirmCodeTextField,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      Visibility(
                          visible: provider.error,
                          child: errorMessage,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: confirmButton,
                )
              ],
            ),
          ),
          Visibility(
              visible: provider.loading,
              child: LoadingWidget(provider.loadingMessage, LURA_BLUE),
          )
        ],
      ),
    );
  }
}
