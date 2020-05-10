import 'package:ble_client_app/dialogs/AddNotesDialog.dart';
import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';

class MainUIScreenButtonRow extends StatelessWidget {
  final DeviceDataProvider provider;

  MainUIScreenButtonRow(this.provider);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
          ),
          color: LURA_BLUE ,
          onPressed: () async {
            final String note = await _notesDialog(context);
            if(note != null && note.length > 0){
              print("We have a note: $note");
              provider.saveNote(note);
            }else{
              print("No notes");
            }
          },
          child: Text("Add note", style: WHITE_TEXT,),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          color: LURA_BLUE,
          onPressed: provider.connectDisconnectFromDevice,
          onLongPress: () => Navigator.pushNamed(context, DEVICE_SCAN_SCREEN) ,
          child: Text(provider.connectDisconnectButtonText, style: WHITE_TEXT,),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          color: LURA_BLUE,
          onPressed: provider.powerOff,
          onLongPress: () => Navigator.pushNamed(context, DEVICE_SCAN_SCREEN) ,
          child: Text("Power off", style: WHITE_TEXT,),
        ),
      ],
    );
  }

  Future<String> _notesDialog(BuildContext context) async {
    return showDialog<String>(
        context: context,
        barrierDismissible: true,
        // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return AddNotesDialog();
        });
  }
}
