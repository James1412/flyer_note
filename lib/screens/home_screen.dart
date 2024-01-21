import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<Color> colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
  ];

  List<String> notes = [
    "hi",
    "this is my note",
    'welcome',
    'nice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet younice to meet you'
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onNoteTap(int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        opaque: false,
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Dialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: Hero(
              transitionOnUserGestures: true,
              tag: index,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("Hi"),
                ),
              ),
            ),
          );
        },
      ),
    );
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
          title: const Text("Notes"),
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
                alignment: WrapAlignment.center,
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
                        onTap: () => _onNoteTap(notes.indexOf(note)),
                        child: Hero(
                          tag: notes.indexOf(note),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              width: Random().nextInt(20) + 170,
                              height: Random().nextInt(10) + 180,
                              padding: EdgeInsets.all(Random().nextInt(20) + 5),
                              decoration: BoxDecoration(
                                color:
                                    colors[Random().nextInt(colors.length) + 0],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                note,
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
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
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
