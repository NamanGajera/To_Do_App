import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:to_do_app/Widget/Buttons/SimpleButton.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> showbottomsheet(
  BuildContext context,
  TextEditingController titlecontroller,
  TextEditingController descriptioncontroller,
) {
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance.collection('ToDo');
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                          controller: descriptioncontroller,
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
                            descriptioncontroller.text.toString().trim(),
                      }).then((value) {
                        // setState(() {
                        //   titlecontroller.clear();
                        //   descriptioncontroller.clear();
                        // });

                        Navigator.pop(context);
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
