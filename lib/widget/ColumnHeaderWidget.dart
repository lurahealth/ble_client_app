import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';

class ColumnHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Time ",style: TextStyle(color: LURA_BLUE, fontSize: 18),),
        new Text("pH", style: TextStyle(color: LURA_ORANGE, fontSize: 18),),
        new Text("pHmV", style: TextStyle(color: LURA_ORANGE, fontSize: 18),),
        new Text("Temp", style: TextStyle(color: LURA_ORANGE,fontSize: 18),),
        new Text("Batt", style: TextStyle(color: LURA_ORANGE,fontSize: 18),),
      ],
    );
  }
}
