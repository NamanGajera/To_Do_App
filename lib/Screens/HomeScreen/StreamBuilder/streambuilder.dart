import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/Screens/HomeScreen/StreamBuilder/showmydialog.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';

StreamBuilder nstreambuilder(
  TextEditingController searchcontroller,
  BuildContext context,
) {
  final _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;
  final uid = user?.uid;

  final firestore = FirebaseFirestore.instance.collection('ToDo');
  final usertodo = FirebaseFirestore.instance
      .collection('ToDo')
      .doc(uid)
      .collection('usertodo')
      .snapshots();
  return StreamBuilder<QuerySnapshot>(
      stream: usertodo,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Some Error'));
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final title = snapshot.data!.docs[index]['title'].toString();
                final description =
                    snapshot.data!.docs[index]['description'].toString();
                final id = snapshot.data!.docs[index]['id'].toString();

                if (searchcontroller.text.isEmpty) {
                  return Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (value) {
                            showmydialog(
                              title,
                              description,
                              id,
                              context,
                            );
                          },
                          autoClose: true,
                          borderRadius: BorderRadius.circular(12.0),
                          flex: 2,
                          backgroundColor: Colors.blue.shade300,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (value) {
                            firestore
                                .doc(uid)
                                .collection('usertodo')
                                .doc(id)
                                .delete()
                                .then((value) {
                              nHelpper().ndeletetoast(context, 'Data');
                            }).onError((error, stackTrace) {
                              nHelpper().nerrortoast(context, error.toString());
                            });
                          },
                          autoClose: true,
                          borderRadius: BorderRadius.circular(12.0),
                          flex: 2,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red.shade400,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 3,
                      color: Colors.deepPurple.shade200,
                      child: ListTile(
                        title: Text(
                          snapshot.data!.docs[index]['title'].toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          snapshot.data!.docs[index]['description'].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.black54),
                        ),
                      ),
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchcontroller.text.toString().toLowerCase())) {
                  return Card(
                    elevation: 3,
                    color: Colors.deepPurple.shade200,
                    child: ListTile(
                      title: Text(
                        snapshot.data!.docs[index]['title'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        snapshot.data!.docs[index]['description'].toString(),
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
      });
}
