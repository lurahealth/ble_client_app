import 'package:ble_client_app/providers/CreateNewUserProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=> CreateNewUserProvider(),
      child: CreateNewUserWidget(),
    );
  }
}

class CreateNewUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CreateNewUserProvider provider = Provider.of<CreateNewUserProvider>(context);

    final patientEmailTextField = textField(NEW_USER_SCREEN_EMAIL_HINT ,
                                     NEW_USER_SCREEN_EMAIL_LABEL,
                                     TextInputType.emailAddress,
                                     provider.checkPatientEmail,
                                     provider.patientEmailValid,
                                     LOGIN_SCREEN_EMAIL_ERROR,
                                     Icons.alternate_email);

    final patientNameTextField = textField(NEW_USER_SCREEN_NAME_HINT,
                                           NEW_USER_SCREEN_NAME_LABEL,
                                           TextInputType.text,
                                           provider.checkPatientName,
                                           provider.patientNameValid,
                                           NEW_USER_SCREEN_NAME_ERROR_TEXT,
                                           Icons.account_circle);

    final patientPasswordTextField = textField(NEW_USER_SCREEN_PASSWORD_HINT,
                                        NEW_USER_SCREEN_PASSWORD_LABEL,
                                        TextInputType.text,
                                        provider.checkPassword,
                                        provider.patientPasswordValid,
                                        NEW_USER_SCREEN_PASSWORD_ERROR,
                                        Icons.lock_outline,
                                        obscureText: !provider.showPassword,
                                        suffixIcon: IconButton(
                                            icon: provider.passwordIcon,
                                            onPressed: provider.togglePasswordVisibility),);

    final confirmPasswordTextField = textField(NEW_USER_SCREEN_CONFIRM_PASSWORD_HINT,
                                               NEW_USER_SCREEN_CONFIRM_PASSWORD_LABEL,
                                               TextInputType.text,
                                               provider.checkConfirmPassword,
                                               provider.patientPasswordConfirmValid,
                                               NEW_USER_SCREEN_CONFIRM_PASSWORD_ERROR,
                                               Icons.lock,
                                               obscureText: !provider.showPassword,
                                               suffixIcon: IconButton(
                                                  icon: provider.passwordIcon,
                                                  onPressed: provider.togglePasswordVisibility),);
    final createUserButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: LURA_BLUE,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => provider.createNewUserButton(context),
        child: Text(
          CREATE_NEW_USER_BUTTON,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,),
        ),
      ),
    );

    final cancelButton = FlatButton(
      onPressed: () => Navigator.pop(context),
      child: new Text("Cancel"),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LURA_BLUE,
        centerTitle: true,
        title: Text("New account"),
        leading: Text(" ",style: LURA_BLUE_TEXT,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: !provider.loading,
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    patientNameTextField,
                    patientEmailTextField,
                    patientPasswordTextField,
                    confirmPasswordTextField,

                  ],
                ),
              ),
            ),
            Visibility(
              visible: !provider.loading,
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: provider.error,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(provider.errorMessage, style: ERROR_TEXT,),
                    ),
                  ),
                  createUserButton,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cancelButton,
                  ),
                ],
              ),
            ),
            Visibility(
                visible: provider.loading,
                child: LoadingWidget("Registering user", LURA_BLUE)
            ),
          ],
        ),
      ),
    );
  }
}

