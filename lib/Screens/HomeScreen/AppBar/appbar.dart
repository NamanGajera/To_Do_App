// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Screens/AuthScreen/LoginScreen.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';

PreferredSizeWidget nappbar(BuildContext context) {
  final _auth = FirebaseAuth.instance;
  return AppBar(
    automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      'ToDo',
      style:
          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
    ),
    leading: Builder(builder: (BuildContext context) {
      return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ));
    }),
    actions: [
      IconButton(
        onPressed: () async {
          try {
            await _auth.signOut().then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
              nHelpper().nsuccesstoast(context, 'Log Out');
            });
          } on FirebaseAuthException catch (e) {
            nHelpper().nerrortoast(context, e.code);
          }
        },
        icon: const Icon(
          Icons.power_settings_new,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 8),
    ],
  );
}
