import 'package:ble_client_app/singletons/CognitoUserSingleton.dart';
import 'package:ble_client_app/singletons/SecureStorageUtils.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreenProvider with ChangeNotifier {
  String email;
  String password;

  bool emailValid = true;
  bool passwordValid = true;

  bool showPassword = false;
  bool loading = false;

  Icon passwordIcon = Icon(Icons.visibility_off, color: LURA_ORANGE,);

  bool loginError = false;
  String loginErrorMessage = "";
  bool loginDetailsChecked = false;

  Future<void> checkLoginDetails(BuildContext context) async {
    if(!loginDetailsChecked){
      loginDetailsChecked = true;
      email = await readFromSecureStorage(SAVED_USER_EMAIL);
      if (email != null) {
        password = await readFromSecureStorage(SAVED_PASSWORD);
        if(password != null){
          loginUser(context);
        }
      }
    }
  }


  Future<void> loginUser(BuildContext context) async {
    checkLoginFields();
    if (email != null && password != null) {
      loginError = false;
      loading = true;
      notifyListeners();

      CognitoUserSingleton.instance
          .loginUser(email, password)
          .then((response) async {
        print("Success: $response");
        loading = false;
        if (response == NEW_PASSWORD_REQUIRED) {
          print("New password required");
          notifyListeners();
        } else if(response == USER_NOT_CONFIRMED){
          print("User confirmation required");
          Navigator.popAndPushNamed(context, CONFIRM_USER_SCREEN);
        }
        else if(response == INCORRECT_USER_NAME_OR_PASSWORD) {
          loginError = true;
          loginErrorMessage = response;
          loading = false;
          notifyListeners();
        }else if(response == USER_LOGGED_IN){
          await saveUserNameAndPassword(email, password);
          Navigator.pushNamedAndRemoveUntil(context, DEVICE_SCAN_SCREEN, (route) => false);
        } else{
          loginError = true;
          loginErrorMessage = response;
          loading = false;
          notifyListeners();
        }
      }, onError: loginFailed);
    }
  }

  void loginFailed(error) {
    print("Error logging in: ${error.toString()}");
    loginError = true;
    loginErrorMessage = error.message;
    loading = false;
    notifyListeners();
  }

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

  checkLoginFields() {
    checkEmail(email);
    checkLoginPassword(password);
  }

  checkEmail(String value) {
    if (value != null && value.length > 0 && EmailValidator.validate(value)) {
      emailValid = true;
      email = value.trim();
    } else {
      emailValid = false;
      email = null;
    }

    notifyListeners();
  }

  checkLoginPassword(String value) {
    if (value != null && value.length > 0) {
      passwordValid = true;
      password = value.trim();
    } else {
      passwordValid = false;
      password = null;
    }

    notifyListeners();
  }
}
