import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flyer_note/models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  final TextEditingController _titleTextEditController =
      TextEditingController();
  final TextEditingController _bodyTextEditController = TextEditingController();
  bool isEditing = false;

  final List<Color> colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
  ];

  List<NoteModel> notes = [
    NoteModel(
        title: "null",
        text:
            'meet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet you',
        backgroundColor: Colors.red.shade100,
        height: 220,
        width: 185),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _titleTextController.dispose();
    _bodyTextController.dispose();
    _titleTextEditController.dispose();
    _bodyTextEditController.dispose();
    super.dispose();
  }

  void _onNoteTap(NoteModel note) {
    Navigator.push(
      context,
      PageRouteBuilder(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Hero(
                flightShuttleBuilder: (flightContext, animation,
                        flightDirection, fromHeroContext, toHeroContext) =>
                    // Container when animating... (to avoid overflow)
                    Container(
                  height: note.height,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: note.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                transitionOnUserGestures: true,
                tag: notes.indexOf(note),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    height: 430,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: note.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 350,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isEditing
                                    ? TextField(
                                        controller: _titleTextEditController,
                                      )
                                    : Text(
                                        note.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isEditing
                                    ? TextField(
                                        controller: _bodyTextEditController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        minLines: 7,
                                        maxLines: 10,
                                      )
                                    : Text(
                                        note.text,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (isEditing)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditing = false;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: SizedBox(
                                      width: 70,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // Edit note button
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (!isEditing) {
                                      _titleTextEditController.text =
                                          note.title;
                                      _bodyTextEditController.text = note.text;
                                    }
                                    if (isEditing) {
                                      note.title =
                                          _titleTextEditController.text;
                                      note.text = _bodyTextEditController.text;
                                    }
                                    isEditing = !isEditing;
                                  });
                                },
                                child: isEditing
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 70,
                                        height: 40,
                                        child: const Center(
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void _onNewNoteTap() {
    Navigator.push(
      context,
      PageRouteBuilder(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          final newBackgroundColor =
              colors[Random().nextInt(colors.length) + 0];
          return GestureDetector(
            onTap: () {
              if (FocusManager.instance.primaryFocus == null) return;
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: 370,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: newBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleTextController,
                        decoration: const InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _bodyTextController,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Note",
                          border: OutlineInputBorder(),
                        ),
                        minLines: 7,
                        maxLines: 10,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _titleTextController.clear();
                                _bodyTextController.clear();
                                Navigator.pop(context);
                              },
                              child: const SizedBox(
                                width: 70,
                                height: 40,
                                child: Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                )),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () => _onNewNoteSaveTap(newBackgroundColor),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 70,
                              height: 40,
                              child: const Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onNewNoteSaveTap(Color backgroundColor) {
    final newNote = NoteModel(
        title: _titleTextController.text,
        text: _bodyTextController.text,
        backgroundColor: backgroundColor,
        height: Random().nextInt(20) + 200,
        width: Random().nextInt(15) + 185);
    setState(() {
      notes.add(newNote);
    });
    _titleTextController.clear();
    _bodyTextController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus == null) return;
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notes",
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: notes.length.isOdd
                    ? WrapAlignment.start
                    : WrapAlignment.center,
                children: [
                  for (var note in notes)
                    Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        notes.remove(note);
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Deleted the note"),
                            action: SnackBarAction(
                              label: "Recover",
                              onPressed: () {
                                notes.add(note);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () => _onNoteTap(note),
                        child: Hero(
                          tag: notes.indexOf(note),
                          child: Padding(
                            padding: notes.length.isOdd
                                ? const EdgeInsets.only(left: 7)
                                : EdgeInsets.zero,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Container(
                                width: note.width,
                                height: note.height,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: note.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      note.text,
                                      maxLines: 7,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          splashColor: Colors.black,
          onPressed: _onNewNoteTap,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
