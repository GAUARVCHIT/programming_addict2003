import 'package:flutter/material.dart';

class NotesForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NotesForListing({
    this.noteID,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
  });

  factory NotesForListing.fromJSON(Map<String, dynamic> item) {
    return NotesForListing(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
