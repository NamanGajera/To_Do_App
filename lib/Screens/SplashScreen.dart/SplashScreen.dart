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
    startanimation();
    splashservices.islogin(context);
  }

  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1500),
            top: animate ? 385 : -40,
            left: 140,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              opacity: animate ? 1 : 0,
              child: Container(
                height: 35,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1700),
            left: 180,
            bottom: animate ? 420 : -30,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1700),
              opacity: animate ? 1 : 0,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: Colors.amber, shape: BoxShape.circle),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            bottom: animate ? 360 : -50,
            left: 180,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: Colors.amber, shape: BoxShape.circle),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future startanimation() async {
    await Future.delayed(const Duration(microseconds: 500));
    setState(() {
      animate = true;
    });
  }
}
