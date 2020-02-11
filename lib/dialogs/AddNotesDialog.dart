import 'package:flutter/material.dart';

class AddNotesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String note = '';
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text('Enter Notes'),
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Notes', hintText: 'Enter Notes'),
                onChanged: (value) {
                  note = value;
                },
              ))
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: () {
            Navigator.of(context).pop(note);
          },
        ),
      ],
    );
  }
}
