import 'package:flutter/material.dart';
import 'package:to_do_app/Const/Colors.dart';
import 'package:to_do_app/Screens/HomeScreen/FloatingActionButton/showbottomsheet.dart';

Widget nfloatingactionbutton(BuildContext context) {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  return FloatingActionButton(
    onPressed: () {
      titlecontroller.clear();
      descriptioncontroller.clear();
      showbottomsheet(context, titlecontroller, descriptioncontroller);
    },
    backgroundColor: nColors.primarycolor,
    elevation: 10,
    focusColor: nColors.primarycolor,
    foregroundColor: nColors.primarycolor,
    child: Text(
      'Add',
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
    ),
  );
}
