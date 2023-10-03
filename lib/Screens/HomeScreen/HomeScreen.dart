// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Const/Colors.dart';
import 'package:to_do_app/Screens/AuthScreen/LoginScreen.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:form_validator/form_validator.dart';
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
  final firestore = FirebaseFirestore.instance.collection('ToDo');

  final formkey = GlobalKey<FormState>();
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
    User? user = _auth.currentUser;
    final uid = user?.uid;
    final usertodo = FirebaseFirestore.instance
        .collection('ToDo')
        .doc(uid)
        .collection('usertodo')
        .snapshots();
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
                onChanged: (value) {
                  setState(() {});
                },
                onTapOutside: nHelpper().hidekeybord,
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: usertodo,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Some Error'));
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            final title =
                                snapshot.data!.docs[index]['title'].toString();
                            final description = snapshot
                                .data!.docs[index]['description']
                                .toString();
                            if (searchcontroller.text.isEmpty) {
                              return Card(
                                elevation: 3,
                                color: Colors.deepPurple.shade200,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data!.docs[index]['title']
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]['description']
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                ),
                              );
                            } else if (title.toLowerCase().contains(
                                searchcontroller.text
                                    .toString()
                                    .toLowerCase())) {
                              return Card(
                                elevation: 3,
                                color: Colors.deepPurple.shade200,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data!.docs[index]['title']
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]['description']
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.black54),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            titlecontroller.clear();
            descriptioncontoller.clear();
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
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Add',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: titlecontroller,
                            decoration: nTextFormFieldDecoration
                                .nTextFormFielsDeco
                                .copyWith(
                              hintText: 'title',
                            ),
                            validator: ValidationBuilder().required().build(),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: descriptioncontoller,
                            decoration: nTextFormFieldDecoration
                                .nTextFormFielsDeco
                                .copyWith(
                              hintText: 'Description',
                            ),
                            maxLines: 4,
                            validator: ValidationBuilder().required().build(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  SimpleButton(
                    loading: false,
                    buttonname: 'Add',
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        User? user = _auth.currentUser;
                        final _uid = user?.uid;
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        firestore.doc(_uid).collection('usertodo').doc(id).set({
                          'id': id,
                          'title': titlecontroller.text.toString().trim(),
                          'description':
                              descriptioncontoller.text.toString().trim(),
                        }).then((value) {
                          setState(() {
                            titlecontroller.clear();
                            descriptioncontoller.clear();
                          });

                          nHelpper().nsuccesstoast(context, 'Add Data');
                        }).onError((error, stackTrace) {
                          nHelpper().nerrortoast(context, error.toString());
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
          );
        });
  }
}
