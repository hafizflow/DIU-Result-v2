import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';

class HTextTheme {
  HTextTheme._();

  static TextTheme textTheme = GoogleFonts.quicksandTextTheme().copyWith(
    labelMedium: GoogleFonts.quicksand(
      color: ColorConstants.offWhite,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.quicksand(
      color: ColorConstants.offWhite,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    titleMedium: GoogleFonts.quicksand(
      color: ColorConstants.offWhite,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    headlineMedium: GoogleFonts.quicksand(
      color: ColorConstants.offWhite,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  );
}
