// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:to_do_app/Utils/Theme/Custom_Themes/text_theme.dart';
import 'package:to_do_app/Utils/Theme/Custom_Themes/elevated_button_theme.dart';

import 'package:to_do_app/Utils/Theme/Custom_Themes/app_bar_theme.dart';

class nAppTheme {
  nAppTheme._();

  static ThemeData lighttheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: nTextTheme.lighttextTheme,
    elevatedButtonTheme: nElevatedButton.lightelevatedButtonTheme,
    appBarTheme: nAppBArTheme.lightAppBarTheme,
  );

  static ThemeData darktheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: nTextTheme.darktextTheme,
  );
}
