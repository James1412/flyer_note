class NoteModel {
  String title;
  String text;
  int backgroundColor;
  double height;
  double width;

  NoteModel(
      {required this.title,
      required this.text,
      required this.backgroundColor,
      required this.height,
      required this.width});

  NoteModel.fromJson({required Map json})
      : title = json['title'],
        text = json['text'],
        backgroundColor = json['backgroundColor'],
        height = json['height'],
        width = json['width'];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "text": text,
      "backgroundColor": backgroundColor,
      "height": height,
      "width": width,
    };
  }
}
