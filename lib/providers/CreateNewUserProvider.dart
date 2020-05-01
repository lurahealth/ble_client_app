import 'package:ble_client_app/singletons/CognitoUserSingleton.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CreateNewUserProvider with ChangeNotifier{
  String patientName;
  String patientEmail;
  String patientPassword;
  String patientPasswordConfirm;

  bool patientNameValid = true;
  bool patientEmailValid = true;
  bool patientPasswordValid = true;
  bool patientPasswordConfirmValid = true;

  Icon passwordIcon = Icon(Icons.visibility_off);
  bool showPassword = false;

  bool error = false;
  String errorMessage;

  bool loading;

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

  void checkPatientName(String value){
    if(value != null && value.length > 0){
      patientName = value;
      patientNameValid = true;
    }else{
      patientName = null;
      patientNameValid = false;
    }

    notifyListeners();
  }

  void checkPatientEmail(String value){
    if(value != null && EmailValidator.validate(value)){
      patientEmail = value;
      patientEmailValid = true;
    }else{
      patientEmail = null;
      patientEmailValid = false;
    }

    notifyListeners();
  }

  void checkPassword(String value) {
    value = value.trim();
    RegExp passwordCheck = RegExp(PASSWORD_REGEX);
    if (value != null && value.length > 0 && passwordCheck.hasMatch(value)) {
      patientPasswordValid = true;
      patientPassword = value;
    } else {
      patientPassword = null;
      patientPasswordValid = false;
    }

    notifyListeners();
  }

  void checkConfirmPassword(String value){
    value = value.trim();
    if(value != null && value == patientPassword){
      patientPasswordConfirm = value;
      patientPasswordConfirmValid = true;
    }else{
      patientPasswordConfirm = null;
      patientPasswordConfirmValid = false;
    }
  }

  void checkFields(){
    checkPatientEmail(patientEmail);
    checkPatientName(patientName);
    checkPassword(patientPassword);
    checkConfirmPassword(patientPasswordConfirm);
  }

  Future<void> createNewUserButton(BuildContext context) async {
    if(patientNameValid && patientEmailValid &&
       patientPasswordValid && patientPasswordConfirmValid){
       CognitoUserSingleton.instance.registerNewPatient(patientEmail, patientName, patientPassword)
                          .then((response) 
       {
         Navigator.popAndPushNamed(context, CONFIRM_USER_SCREEN);
       }, 
           onError: newUserCreationError);
           print("Patinet registered!");
    }
  }

  void newUserCreationError(error){
    print(error);
    error = true;
    errorMessage = error.toString();
  }
}