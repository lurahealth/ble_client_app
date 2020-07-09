import 'package:ble_client_app/providers/LoginScreenProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:ble_client_app/widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginScreenProvider() ,
      child: LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final LoginScreenProvider provider = Provider.of<LoginScreenProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if(!provider.loginDetailsChecked) {
      provider.checkLoginDetails(context);
    }

    final titleBlock = Container(
        height: height * 0.25,
        decoration: BoxDecoration(
            color: LURA_BLUE,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32))),
        child: Center(
          child: Column(
            children: <Widget>[
//              SizedBox(height: MediaQuery.of(context).size.height*0.06 ,),
              Image.asset("images/logo.png"),
            ],
          ),
        )
    );

    final emailTextField = textField(LOGIN_SCREEN_EMAIL_HINT,
        LOGIN_SCREEN_EMAIL_LABEL,
        TextInputType.emailAddress,
        provider.checkEmail,
        provider.emailValid,
        LOGIN_SCREEN_EMAIL_ERROR,
        Icons.alternate_email);

    final passwordTextField = textField(LOGIN_SCREEN_PASSWORD_HINT,
      LOGIN_SCREEN_PASSWORD_LABEL,
      TextInputType.text,
      provider.checkLoginPassword,
      provider.passwordValid,
      LOGIN_SCREEN_PASSWORD_ERROR,
      Icons.vpn_key,
      obscureText: !provider.showPassword,
      suffixIcon: IconButton(
          icon: provider.passwordIcon,
          onPressed: provider.togglePasswordVisibility),);


    final errorText = Visibility(
      visible: provider.loginError,
      child: new Text(
        provider.loginErrorMessage,
        style: ERROR_TEXT,
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: LURA_BLUE,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => provider.loginUser(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(
              LOGIN_BUTTON_TEST,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,),
            ),
          ],
        ),
      ),
    );

    final newAccountButton = Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 5.0,
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => Navigator.pushNamed(context, NEW_USER_SCREEN),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Icon(
//              Icons.play_arrow,
//              color: Colors.white,
//            ),
            SizedBox(width: 10,),
            Text(
              NEW_USER_BUTTON_TEXT,
              textAlign: TextAlign.center,
              style: LURA_BLUE_TEXT,
            ),
          ],
        ),
      ),
    );

//    final newAccountButton = FlatButton(
//      onPressed: () => Navigator.pushNamed(context, NEW_USER_SCREEN),
//      child: new Text(NEW_USER_BUTTON_TEXT, style: LURA_BLUE_TEXT,),
//    );
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Text("",style: LURA_BLUE_TEXT, // used to get rid of the random back arrow that keeps poping up
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                titleBlock,
                SizedBox(height: height*0.08 ,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: emailTextField,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: passwordTextField,
                ),
                SizedBox(height: height*0.04 ,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: !provider.loading,
                          child: loginButton
                      ),
                      Visibility(
                        visible: provider.loading,
                        child: LoadingWidget("Logging in", LURA_BLUE)
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: newAccountButton,
                )
              ],
            ),
          ),
          errorText,
//          Padding(
//            padding: const EdgeInsets.all(32.0),
//            child: newAccountButton,
//          )
        ],
      ),
    );
  }
}
