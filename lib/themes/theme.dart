import 'package:flutter/material.dart';
import 'package:riverpod_practice/themes/input_decoration_theme.dart';
import 'package:riverpod_practice/themes/text_theme.dart';

class DIUResultAppTheme {
  DIUResultAppTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: Colors.white,
    inputDecorationTheme: HInputDecorationTheme.inputDecorationTheme,
    textTheme: HTextTheme.textTheme,
  );
}
