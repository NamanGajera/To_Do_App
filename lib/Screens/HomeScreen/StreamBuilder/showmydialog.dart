import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/Const/Colors.dart';

Future<void> showmydialog(
  String title,
  String description,
  String id,
  BuildContext context,
) {
  final auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  final edittitlecontroller = TextEditingController();
  final editdescriptioncontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('ToDo');
  edittitlecontroller.text = title;
  editdescriptioncontroller.text = description;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Text(
                  'Update',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: edittitlecontroller,
                  decoration:
                      nTextFormFieldDecoration.nTextFormFielsDeco.copyWith(
                    hintText: 'title',
                  ),
                  validator: ValidationBuilder().required().build(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: editdescriptioncontroller,
                  decoration: nTextFormFieldDecoration.nTextFormFielsDeco
                      .copyWith(hintText: 'Description'),
                  maxLines: 2,
                  validator: ValidationBuilder().required().build(),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                User? user = auth.currentUser;
                final uid = user?.uid;
                firestore.doc(uid).collection('usertodo').doc(id).update({
                  'title': edittitlecontroller.text.toString().trim(),
                  'description':
                      editdescriptioncontroller.text.toString().trim(),
                }).then((value) {
                  Navigator.pop(context);
                  nHelpper().nsuccesstoast(context, 'Update');
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                  nHelpper().nerrortoast(context, error.toString());
                });
              }
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
    },
  );
}
