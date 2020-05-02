import 'package:ble_client_app/providers/LoginScreenProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
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

    final title = Text(
      LOGIN_SCREEN_TITLE,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30, color: LURA_BLUE),
    );

    final titleBlock = Container(
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
          color: LURA_BLUE,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32))),
      child: Center(
        child: Column(
          children: <Widget>[
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
        minWidth: MediaQuery.of(context).size.width,
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
    
    final newAccountButton = FlatButton(
        onPressed: () => Navigator.pushNamed(context, NEW_USER_SCREEN), 
        child: new Text(NEW_USER_BUTTON_TEXT),
    );
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Text("",style: LURA_BLUE_TEXT, // used to get rid of the random back arrow that keeps poping up
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          titleBlock,
          SizedBox(height: MediaQuery.of(context).size.height*0.08 ,),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: emailTextField,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: passwordTextField,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04 ,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: loginButton,
                ),
              ],
            ),
          ),
          errorText,
          newAccountButton
        ],
      ),
    );
  }
}