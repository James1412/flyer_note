import 'package:flyer_note/box_names.dart';
import 'package:flyer_note/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final originalBox = Hive.box(originalBoxName);
final deletedBox = Hive.box(deletedBoxName);

class OriginalNoteDatabase {
  void updateNotes(List<Map<String, dynamic>> notes) {
    originalBox.put(originalBoxName, notes);
  }

  List<dynamic> getNotes() {
    return originalBox.get(originalBoxName) ??
        [
          NoteModel(
                  title: "Welcome",
                  text:
                      "Hi, you can tap to view in larger box and swipe to delete the note",
                  backgroundColor: 0xFFFFCDD2,
                  height: 180,
                  width: 180)
              .toJson(),
        ];
  }
}

class DeletedNotesDatabase {
  void updateNotes(List<Map<String, dynamic>> notes) {
    originalBox.put(deletedBoxName, notes);
  }

  List<dynamic> getNotes() {
    return originalBox.get(deletedBoxName) ?? [];
  }
}
