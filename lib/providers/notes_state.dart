import 'dart:math';

import 'package:dam_labs/model/note.dart';
import 'package:flutter/material.dart';

class NotesState with ChangeNotifier {
  final List<Note> _notes = [];

  int get notesCount => notes.length;
  List<Note> get notes => [..._notes];

  void addNote(Map<String, Object> data) {
    final hasId = data['id'] != null;

    final note = Note(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
    );

    if (hasId) {
      int index = _notes.indexWhere(
        (n) => n.id == note.id,
      );
      _notes[index] = note;
    } else {
      _notes.add(note);
    }

    notifyListeners();
  }

  void removeNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
