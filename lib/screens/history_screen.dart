import 'package:flutter/material.dart';
import 'package:flyer_note/admob.dart';
import 'package:flyer_note/models/note_model.dart';
import 'package:flyer_note/view_models/original_notes_vm.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  final isScreenshot;
  const HistoryScreen({super.key, required this.isScreenshot});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  BannerAd? _ad;
  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_ad != null) {
      _ad!.dispose();
    }
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
                tag: context.watch<DeletedNotesViewModel>().notes.indexOf(note),
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
                          child: GestureDetector(
                              onTap: () {
                                context
                                    .read<DeletedNotesViewModel>()
                                    .recoverNote(note, context);
                                Navigator.pop(context);
                              },
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
          actions: [
            IconButton(
                onPressed: () {
                  context.read<DeletedNotesViewModel>().deleteNotes();
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            children: [
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 13,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  for (var note in context.watch<DeletedNotesViewModel>().notes)
                    GestureDetector(
                      onTap: () => _onNoteTap(note),
                      child: Hero(
                        tag: context
                            .watch<DeletedNotesViewModel>()
                            .notes
                            .indexOf(note),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                ],
              ),
            ],
          ),
        ),
        // admob
        bottomNavigationBar: !widget.isScreenshot
            ? _ad != null
                ? BottomAppBar(
                    surfaceTintColor: Colors.transparent,
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    height: 70,
                    elevation: 0,
                    child: SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: AdWidget(ad: _ad!),
                    ),
                  )
                : null
            : null,
      ),
    );
  }
}
