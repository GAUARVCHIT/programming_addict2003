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
}
