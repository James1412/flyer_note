import 'package:flutter/material.dart';
import 'package:flyer_note/databases/note_db.dart';
import 'package:flyer_note/models/note_model.dart';
import 'package:provider/provider.dart';

class OriginalNotesViewModel extends ChangeNotifier {
  late List<dynamic> roughNotes = originalDB.getNotes();
  late List<NoteModel> notes = [
    for (var note in roughNotes) NoteModel.fromJson(json: note),
  ];

  final originalDB = OriginalNoteDatabase();

  void addNote(NoteModel note) {
    notes.add(note);
    List<Map<String, dynamic>> noteMap = [];
    for (NoteModel note in notes) {
      final newNote = note.toJson();
      noteMap.add(newNote);
    }
    originalDB.updateNotes(noteMap);
    notifyListeners();
  }

  void deleteNote(note, BuildContext context) {
    notes.remove(note);
    List<Map<String, dynamic>> noteMap = [];
    for (NoteModel note in notes) {
      final newNote = note.toJson();
      noteMap.add(newNote);
    }
    originalDB.updateNotes(noteMap);
    context.read<DeletedNotesViewModel>().addNote(note);
    notifyListeners();
  }
}

class DeletedNotesViewModel extends ChangeNotifier {
  late List<dynamic> roughNotes = deletedDB.getNotes();
  late List<NoteModel> notes = [
    for (var note in roughNotes) NoteModel.fromJson(json: note),
  ];

  final deletedDB = DeletedNotesDatabase();

  void addNote(NoteModel note) {
    notes.add(note);
    List<Map<String, dynamic>> noteMap = [];
    for (NoteModel note in notes) {
      final newNote = note.toJson();
      noteMap.add(newNote);
    }
    deletedDB.updateNotes(noteMap);
    notifyListeners();
  }

  void deleteNotes() {
    notes = [];
    deletedDB.updateNotes([]);
    notifyListeners();
  }

  void recoverNote(NoteModel note, BuildContext context) {
    notes.remove(note);
    List<Map<String, dynamic>> noteMap = [];
    for (NoteModel note in notes) {
      final newNote = note.toJson();
      noteMap.add(newNote);
    }
    deletedDB.updateNotes(noteMap);
    context.read<OriginalNotesViewModel>().addNote(note);
    notifyListeners();
  }
}
