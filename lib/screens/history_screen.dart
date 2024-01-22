import 'package:flutter/material.dart';
import 'package:flyer_note/models/note_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

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
  void dispose() {
    _scrollController.dispose();

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
                tag: notes.indexOf(note),
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
                                Text(
                                  note.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
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
                              // Edit note button
                              GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 70,
                                    height: 40,
                                    child: const Center(
                                      child: Text(
                                        "Recover",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )),
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
            "History",
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            children: [
              ListTile(
                tileColor: Colors.grey.shade200,
                leading: const Icon(Icons.info_rounded),
                title: const Text(
                    "Notes will be permanently deleted after 30 days"),
              ),
              const SizedBox(
                height: 10,
              ),
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
                                  color: Color(note.backgroundColor),
                                  borderRadius: BorderRadius.circular(10),
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
