import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// colours
const Color LURA_BLUE = Color(0xFF405280);
const  Color LURA_LIGHT_BLUE = Colors.lightBlue;
const Color LURA_ORANGE = Colors.deepOrangeAccent;
const Color LIGHT_GREEN = Colors.lightGreen;

// TextStyle
const TextStyle WHITE_TEXT = TextStyle(color: Colors.white);
const TextStyle ERROR_TEXT = TextStyle(color: Colors.redAccent, fontSize: 13);
const TextStyle LURA_BLUE_TEXT = TextStyle(color: LURA_BLUE);

Column textField(String hint, String label, TextInputType inputType,
    Function onChangeListener, bool textValid, String errorText, IconData prefixIcon,
    {bool obscureText = false, IconButton suffixIcon}) {
  return Column(
    children: <Widget>[
      TextField(
        keyboardType: inputType,
        obscureText: obscureText,
        onChanged: onChangeListener,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
          hintText: hint,
          labelText: label,),
      ),
      Visibility(
          visible: !textValid,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  errorText,
                  style: ERROR_TEXT,
                ),
              ],
            ),
          ))
    ],
  );
}

AppBar getStandardAppBar(BuildContext context, {List<Widget> actions}){
  return AppBar(
      elevation: 0,
      backgroundColor: LURA_BLUE,
      actions: actions,
      centerTitle: true,
      title: Image.asset("images/logo.png"),
  );
}