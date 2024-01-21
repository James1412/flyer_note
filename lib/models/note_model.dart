import 'dart:ui';

class NoteModel {
  String title;
  String text;
  Color backgroundColor;
  double height;
  double width;

  NoteModel(
      {required this.title,
      required this.text,
      required this.backgroundColor,
      required this.height,
      required this.width});
}
