import 'package:flutter/material.dart';
import 'package:flyer_note/databases/note_db.dart';
import 'package:flyer_note/models/note_model.dart';

class OriginalNotesViewModel extends ChangeNotifier {
  late List<dynamic> roughNotes = db.getNotes();
  late List<NoteModel> notes = [
    for (var note in roughNotes) NoteModel.fromJson(json: note),
  ];

  final db = OriginalNoteDatabase();

  void addNote(NoteModel note) {
    notes.add(note);
    List<Map<String, dynamic>> noteMap = [];
    for (NoteModel note in notes) {
      final newNote = note.toJson();
      noteMap.add(newNote);
    }
    db.updateNotes(noteMap);
    notifyListeners();
  }

  void deleteNote(note) {
    notes.remove(note);
    List<Map<String, dynamic>> noteMap = [];
    for (NoteModel note in notes) {
      final newNote = note.toJson();
      noteMap.add(newNote);
    }
    db.updateNotes(noteMap);
    notifyListeners();
  }
}
