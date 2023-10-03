// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Const/Colors.dart';
import 'package:to_do_app/Screens/AuthScreen/LoginScreen.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:to_do_app/Widget/Buttons/RoundButton.dart';

import 'package:to_do_app/Widget/Buttons/SimpleButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final searchcontroller = TextEditingController();
  final titlecontroller = TextEditingController();
  final descriptioncontoller = TextEditingController();
  String username = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    User? user = _auth.currentUser;
    final _uid = user?.uid;

    final DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('Users').doc(_uid).get();

    setState(() {
      username = userdoc.get('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        drawer: const Drawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'ToDo',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              TextField(
                controller: searchcontroller,
                decoration:
                    nTextFormFieldDecoration.nTextFormFielsDeco.copyWith(
                  prefixIcon: const Icon(CupertinoIcons.search),
                  hintText: 'Search',
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showbottomsheet();
          },
          backgroundColor: nColors.primarycolor,
          elevation: 10,
          focusColor: nColors.primarycolor,
          foregroundColor: nColors.primarycolor,
          child: Text(
            'Add',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> showbottomsheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Add',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: titlecontroller,
                        decoration: nTextFormFieldDecoration.nTextFormFielsDeco
                            .copyWith(
                          hintText: 'title',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: descriptioncontoller,
                        decoration: nTextFormFieldDecoration.nTextFormFielsDeco
                            .copyWith(
                          hintText: 'Description',
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SimpleButton(
                  loading: false,
                  buttonname: 'Add',
                  onTap: () {},
                ),
                const SizedBox(height: 2),
              ],
            ),
          );
        });
  }
}
