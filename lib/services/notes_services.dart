import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:programmingaddict2003/models/api_response.dart';
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
          final note = NotesForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestEditDateTime'] != null
                ? DateTime.parse(item['latestEditDateTime'])
                : null,
          );
          notes.add(note);
        }
        return APIResponse<List<NotesForListing>>(data: notes);
      }
      return APIResponse<List<NotesForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NotesForListing>>(
        error: true, errorMessage: 'An error occured'));
  }
}
