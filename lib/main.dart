import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Screens/SplashScreen.dart/SplashScreen.dart';
import 'package:to_do_app/Utils/Theme/Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: nAppTheme.lighttheme,
      darkTheme: nAppTheme.darktheme,
      home: const SplashScreen(),
    );
  }
}
