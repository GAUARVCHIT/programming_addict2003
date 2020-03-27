import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:programmingaddict2003/models/note_insert.dart';
import 'package:programmingaddict2003/services/notes_services.dart';
import 'package:programmingaddict2003/models/note.dart';

class noteModify extends StatefulWidget {
  final String noteId;

  noteModify({this.noteId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return noteModifyState();
  }
}

class noteModifyState extends State<noteModify> {
  bool get isEditing => widget.noteId != null;

  NotesService get notesService => GetIt.I<NotesService>();
  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isEditing != null) {
      setState(() {
        _isLoading = true;
      });

      notesService.getNote(widget.noteId).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occured';
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'EditNode' : 'Create Node'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note title'),
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _contentController,
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
//                      onPressed: Navigator.of(context).pop,
                      onPressed: () async {
                        if (isEditing) {
                        } else {
                          final note = NoteInsert(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text,
                          );
                          final result = await notesService.createNote(note);

                          final title = 'Done';
                          final text = result.errorMessage;

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ));
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
