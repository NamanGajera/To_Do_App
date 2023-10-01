// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:to_do_app/Firebase_Services/Splash_Services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashservices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashservices.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Splash Screen'),
          )
        ],
      ),
    );
  }
}
