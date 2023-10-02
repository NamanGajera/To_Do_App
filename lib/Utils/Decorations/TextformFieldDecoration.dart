// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:to_do_app/Const/Colors.dart';

class nTextFormFieldDecoration {
  static InputDecoration nTextFormFielsDeco = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: nColors.primarycolor, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: nColors.primarycolor, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
