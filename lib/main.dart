import 'package:flutter/material.dart';
import 'package:flyer_note/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlyerNoteApp());
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
