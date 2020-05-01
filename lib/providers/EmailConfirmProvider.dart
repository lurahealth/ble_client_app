import 'package:flutter/material.dart';
import 'package:ble_client_app/singletons/CognitoUserSingleton.dart';

class ConfirmUserScreenProvider with ChangeNotifier{
  String confirmationCode;
  bool confirmationCodeValid = true;

  void checkConfirmationCode(String value){
    if(value != null && value.length > 0){
      confirmationCode = value;
      confirmationCodeValid = true;
    }else{
      confirmationCode = null;
      confirmationCodeValid = false;
    }
  }

  Future<void> sendConfirmCode() async {
    if(confirmationCodeValid){
      bool result = await CognitoUserSingleton.instance
                                              .confirmUser(confirmationCode);
      print("Confirmation result: $result");
    }
  }
}