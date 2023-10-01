import 'package:flutter/material.dart';
import 'package:to_do_app/Screens/AuthScreen/LoginScreen.dart';
import 'package:to_do_app/Screens/SplashScreen.dart/SplashScreen.dart';
import 'package:to_do_app/Utils/Theme/Theme.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: nAppTheme.lighttheme,
      darkTheme: nAppTheme.darktheme,
      home: const LoginScreen(),
    );
  }
}
