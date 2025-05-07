import 'package:flutter/material.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';

class HInputDecorationTheme {
  HInputDecorationTheme._();

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: ColorConstants.offDark,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    suffixIconColor: ColorConstants.offWhite,
    isDense: true,
  );
}
