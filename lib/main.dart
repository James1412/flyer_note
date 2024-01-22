import 'package:flutter/material.dart';
import 'package:flyer_note/box_names.dart';
import 'package:flyer_note/screens/home_screen.dart';
import 'package:flyer_note/view_models/original_notes_vm.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(originalBoxName);
  await Hive.openBox(deletedBoxName);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OriginalNotesViewModel()),
        ChangeNotifierProvider(create: (context) => DeletedNotesViewModel()),
      ],
      child: const FlyerNoteApp(),
    ),
  );
}

class FlyerNoteApp extends StatelessWidget {
  const FlyerNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          outlineBorder: BorderSide(color: Colors.black),
        ),
        textTheme: Typography.blackCupertino,
        scaffoldBackgroundColor: Colors.white,
        snackBarTheme: const SnackBarThemeData(
          actionTextColor: Colors.blue,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
