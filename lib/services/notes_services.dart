import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:programmingaddict2003/models/api_response.dart';
import 'package:programmingaddict2003/models/note.dart';
import 'package:programmingaddict2003/models/note_insert.dart';
import 'package:programmingaddict2003/models/notes_for_listing.dart';

class NotesService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {'apiKey': 'abb09339-f529-4e0f-bea9-0521b8a42d32'};

  Future<APIResponse<List<NotesForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final notes = <NotesForListing>[];
        for (var item in jsonData) {
          notes.add(NotesForListing.fromJSON(item));
        }
        return APIResponse<List<NotesForListing>>(data: notes);
      }
      return APIResponse<List<NotesForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NotesForListing>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Note>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createNote(NoteInsert item) {
    return http
        .post(API + '/notes', headers: headers, body: jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<Note>(error: true, errorMessage: 'An error occured'));
  }
}
