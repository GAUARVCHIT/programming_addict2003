import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:programmingaddict2003/models/api_response.dart';
import 'package:programmingaddict2003/models/notes_for_listing.dart';
import 'package:programmingaddict2003/services/notes_services.dart';
import 'package:programmingaddict2003/views/node_delete.dart';
import 'package:programmingaddict2003/views/note_modify.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  APIResponse<List<NotesForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Notes '),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => noteModify()),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return CircularProgressIndicator();
            }
            if (_apiResponse.error) {
              return Center(
                child: Text(_apiResponse.errorMessage),
              );
            }
            return ListView.separated(
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data[index].noteID),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => NodeDelete());
                      print(result);
                      return result;
                    },
                    child: ListTile(
                      title: Text(
                        _apiResponse.data[index].noteTitle,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                          'Last edited on ${formatDateTime(_apiResponse.data[index].latestEditDateTime)}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => noteModify(
                              noteId: _apiResponse.data[index].noteID,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: Colors.green,
                    ),
                itemCount: _apiResponse.data.length);
          },
        ));
  }
}
