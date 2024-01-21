import 'package:flutter/material.dart';
import 'package:flyer_note/databases/note_db.dart';
import 'package:flyer_note/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OriginalNoteDatabase()),
        ChangeNotifierProvider(create: ((context) => DeletedDatabase())),
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
