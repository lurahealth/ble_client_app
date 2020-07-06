import 'package:flutter/material.dart';

class ColumnHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Time",style: TextStyle(fontSize: 20),),
        new Text("pH", style: TextStyle(color: Colors.orange,fontSize: 20),),
        new Text("pHmV", style: TextStyle(color: Colors.purple, fontSize: 20),),
        new Text("Temp", style: TextStyle(color: Colors.blue,fontSize: 20),),
        new Text("Batt", style: TextStyle(color: Colors.red,fontSize: 20),),
      ],
    );
  }
}
