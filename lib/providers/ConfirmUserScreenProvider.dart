import 'package:ble_client_app/models/LoginDetails.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/material.dart';
import 'package:ble_client_app/singletons/CognitoUserSingleton.dart';

class ConfirmUserScreenProvider with ChangeNotifier{

  final LoginDetails _loginDetails;
  ConfirmUserScreenProvider(this._loginDetails);

  String confirmationCode;
  bool confirmationCodeValid = true;

  bool error = false;
  String errorMessage = "";

  bool loading = false;
  String loadingMessage = "";

  void checkConfirmationCode(String value){
    if(value != null && value.length > 0){
      confirmationCode = value;
      confirmationCodeValid = true;
    }else{
      confirmationCode = null;
      confirmationCodeValid = false;
    }
  }

  Future<void> sendConfirmCode(BuildContext context) async {
    if(confirmationCodeValid){
      loading = true;
      loadingMessage = "Checking confirm code";
      notifyListeners();
      CognitoUserSingleton.instance.confirmUser(confirmationCode)
                          .then((result)
      {
        if(result){
          loadingMessage = "Loggin you in!";
          notifyListeners();
//          loading = false;
          CognitoUserSingleton.instance
              .loginUser(_loginDetails.userName, _loginDetails.password)
              .then((response) {
            print("Success: $response");
            loading = false;
            if (response == NEW_PASSWORD_REQUIRED) {
              print("New password required");
              notifyListeners();
            } else if(response == USER_NOT_CONFIRMED){
              print("User confirmation required");
              Navigator.popAndPushNamed(context, CONFIRM_USER_SCREEN);
            }
            else {
              Navigator.popAndPushNamed(context, DEVICE_SCAN_SCREEN);
            }
          }, onError: (_) => Navigator.popAndPushNamed(context, LOGIN_SCREEN));
        }else{
          loading = false;
          error = true;
          errorMessage = "Error confirming user";
        }

        notifyListeners();
      },
          onError: confirmingUserError);
    }
  }


  void confirmingUserError(error){
    loading = false;
    this.error = true;
    errorMessage = error;
    notifyListeners();
  }
}