import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flyer_note/models/note_model.dart';
import 'package:flyer_note/screens/history_screen.dart';
import 'package:flyer_note/screens/settings_screen.dart';
import 'package:flyer_note/view_models/original_notes_vm.dart';
import 'package:provider/provider.dart';

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

  final List<int> colors = [
    0xFFFFCDD2,
    0xFFBBDEFB,
    0xFFC8E6C9,
    0xFFFFF9C4,
    0xFFFFE0B2,
    0xFFE1BEE7,
    0xFFB2EBF2,
  ];

  List<NoteModel> notes = [
    NoteModel(
        title: "null",
        text:
            'meet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet youmeet younice to meet you',
        backgroundColor: 0xFFFFCDD2,
        height: 220,
        width: 185),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _titleTextController.dispose();
    _bodyTextController.dispose();
    _titleTextEditController.dispose();
    _bodyTextEditController.dispose();
    super.dispose();
  }

  Future<void> _onNoteTap(NoteModel note) async {
    await Navigator.push(
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
                    color: Color(note.backgroundColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                transitionOnUserGestures: true,
                tag:
                    context.watch<OriginalNotesViewModel>().notes.indexOf(note),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    height: 430,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(note.backgroundColor),
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
                                            fontSize: 25),
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
                                        style: const TextStyle(fontSize: 20),
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
    setState(() {});
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
                  height: 390,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(newBackgroundColor),
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
                        maxLines: 7,
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

  void _onNewNoteSaveTap(int backgroundColor) {
    final newNote = NoteModel(
        title: _titleTextController.text,
        text: _bodyTextController.text,
        backgroundColor: backgroundColor,
        height: Random().nextInt(20) + 200,
        width: Random().nextInt(15) + MediaQuery.of(context).size.width * 0.42);
    setState(() {
      context.read<OriginalNotesViewModel>().addNote(newNote);
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
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        body: RawScrollbar(
          radius: const Radius.circular(20),
          thumbColor: Colors.black.withOpacity(0.3),
          interactive: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            children: [
              Wrap(
                spacing: 13,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  for (var note
                      in context.watch<OriginalNotesViewModel>().notes)
                    Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        context.read<OriginalNotesViewModel>().deleteNote(note);
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Deleted the note"),
                            action: SnackBarAction(
                              label: "Recover",
                              onPressed: () {
                                context
                                    .read<OriginalNotesViewModel>()
                                    .addNote(note);
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () => _onNoteTap(note),
                          child: Hero(
                            tag: context
                                .watch<OriginalNotesViewModel>()
                                .notes
                                .indexOf(note),
                            child: Material(
                              type: MaterialType.transparency,
                              child: Container(
                                width: note.width,
                                height: note.height,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(note.backgroundColor),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (note.title != "")
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
                                      style: const TextStyle(fontSize: 17),
                                      maxLines: 5,
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
        // admob
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          height: 70,
          elevation: 0,
          child: Container(
            color: Colors.black,
            width: double.infinity,
            height: 70,
          ),
        ),
      ),
    );
  }
}
