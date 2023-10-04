// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:to_do_app/Screens/AuthScreen/LoginScreen.dart';
import 'package:to_do_app/Screens/HomeScreen/FloatingActionButton/floatingactionbutton.dart';
import 'package:to_do_app/Screens/HomeScreen/StreamBuilder/streambuilder.dart';
import 'package:to_do_app/Screens/HomeScreen/AppBar/appbar.dart';
import 'package:to_do_app/Screens/HomeScreen/SearchBar/searchbar.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:to_do_app/Const/Colors.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:to_do_app/Widget/Card/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final searchcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String username = '';
  String useremail = '';
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        drawer: Drawer(
          backgroundColor: Colors.deepPurple.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: double.infinity,
                color: Colors.deepPurple.shade300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.profile_circled,
                      color: Colors.white,
                      size: 120,
                    ),
                    const SizedBox(height: 10),
                    Stack(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          username,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 3),
                        child: InkWell(
                          onTap: () {
                            showmydialog();
                          },
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              CupertinoIcons.pencil_circle,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Text(useremail,
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  nHelpper().nsuccesstoast(context, 'Open Home');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ncard(context, 'Home'),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  nHelpper().nsuccesstoast(context, 'Open Profile');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ncard(context, 'Profile'),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  nHelpper().nsuccesstoast(context, 'Open Setting');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ncard(context, 'Setting'),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  try {
                    await auth.signOut().then((value) {
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ncard(context, 'Logout'),
                ),
              ),
            ],
          ),
        ),
        //App Bar
        appBar: nappbar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              //Searchbar
              nsearchbar(
                searchcontroller: searchcontroller,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              //Showing Todos
              nstreambuilder(searchcontroller, context),
            ],
          ),
        ),
        //Add Todos
        floatingActionButton: nfloatingactionbutton(context),
      ),
    );
  }

  Future<void> showmydialog() {
    User? user = auth.currentUser;
    final uid = user?.uid;
    usernamecontroller.text = username;
    final userref = FirebaseFirestore.instance.collection('Users').doc(uid);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.138,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Update',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    child: TextFormField(
                      controller: usernamecontroller,
                      decoration: nTextFormFieldDecoration.nTextFormFielsDeco,
                      validator: ValidationBuilder().required().build(),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await userref.update({
                    'name': usernamecontroller.text.toString().trim(),
                  }).then((value) {
                    Navigator.pop(context);
                    getdata();
                    nHelpper().nsuccesstoast(context, 'Update');
                  }).onError((error, stackTrace) {
                    Navigator.pop(context);
                    nHelpper().nerrortoast(context, error.toString());
                  });
                },
                child: Text(
                  'Update',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: nColors.primarycolor,
                      ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancle',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: nColors.primarycolor,
                      ),
                ),
              ),
            ],
          );
        });
  }

  void getdata() async {
    User? user = auth.currentUser;
    final uid = user?.uid;

    final DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    setState(() {
      username = userdoc.get('name');
      useremail = userdoc.get('email');
    });
  }
}
