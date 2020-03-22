import 'package:flutter/material.dart';

class noteModify extends StatelessWidget {
  final String noteId;

  noteModify({this.noteId});

  bool get isEditing => noteId != null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'EditNode' : 'Create Node'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(hintText: 'Note Content'),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: Navigator.of(context).pop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
