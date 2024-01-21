import 'dart:ui';

class NoteModel {
  final String title;
  final String text;
  final Color backgroundColor;
  final double height;
  final double width;

  NoteModel(
      {required this.title,
      required this.text,
      required this.backgroundColor,
      required this.height,
      required this.width});
}
