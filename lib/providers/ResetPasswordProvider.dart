import 'package:ble_client_app/singletons/CognitoUserSingleton.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider with ChangeNotifier{
  String newPassword;
  String confirmNewPassword;

  bool confirmNewPasswordValid = true;
  bool newPasswordValid = true;

  bool passwordResetError = false;
  String passwordResetErrorMessage = "";

  bool loading = false;

  bool showPassword = false;

  Icon passwordIcon = Icon(Icons.visibility_off);

  void togglePasswordVisibility() {
    if (showPassword) {
      showPassword = false;
      passwordIcon = Icon(Icons.visibility_off);
    } else {
      showPassword = true;
      passwordIcon = Icon(Icons.visibility);
    }

    notifyListeners();
  }

  void checkFields() {
    newPasswordCheck(newPassword);
    confirmNewPasswordCheck(confirmNewPassword);
  }

  void confirmNewPasswordCheck(String value) {
    value = value.trim();
    if (value != null && value.length > 0 && value == newPassword) {
      confirmNewPasswordValid = true;
      confirmNewPassword = value.trim();
    } else {
      confirmNewPasswordValid = false;
      confirmNewPassword = null;
    }
    notifyListeners();
  }

  void newPasswordCheck(String value) {
    value = value.trim();
    RegExp passwordCheck = RegExp(PASSWORD_REGEX);
    if (value != null && value.length > 0 && passwordCheck.hasMatch(value)) {
      newPasswordValid = true;
      newPassword = value;
    } else {
      newPassword = null;
      newPasswordValid = false;
    }

    notifyListeners();
  }

  void resetPassword(BuildContext context) {
    checkFields();
    if (newPasswordValid && confirmNewPasswordValid) {
      print("Resetting password");
      CognitoUserSingleton.instance.newUserPasswordReset(newPassword).then(
              (response) {
            print("Password reset succcess $response");
//            Navigator.popAndPushNamed(context, GRAPH_SCREEN);
          }, onError: passwordResetFailed);
    }
  }

  void passwordResetFailed(error) {
    print("Password rest failed ${error.toString()}");
  }
}