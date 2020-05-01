import 'package:ble_client_app/providers/EmailConfirmProvider.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => ConfirmUserScreenProvider(),
      child: ConfirmUserWidget(),
    );
  }

}

class ConfirmUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ConfirmUserScreenProvider provider = Provider.of<ConfirmUserScreenProvider>(context);

    final confirmCodeTextField = TextField(
      onChanged: provider.checkConfirmationCode,
    );

    final confirmButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: LURA_BLUE,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed:provider.sendConfirmCode,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(
              "Send confirm code",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: confirmCodeTextField,
          ),
          confirmButton
        ],
      ),
    );
  }
}

