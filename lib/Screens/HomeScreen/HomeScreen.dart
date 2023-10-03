// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Screens/HomeScreen/FloatingActionButton/floatingactionbutton.dart';
import 'package:to_do_app/Screens/HomeScreen/StreamBuilder/streambuilder.dart';
import 'package:to_do_app/Screens/HomeScreen/AppBar/appbar.dart';
import 'package:to_do_app/Screens/HomeScreen/SearchBar/searchbar.dart';

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
  String username = '';
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    User? user = _auth.currentUser;
    final uid = user?.uid;

    final DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

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
}
