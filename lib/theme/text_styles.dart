import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_colors.dart';

class TextStyles {
  static TextStyle notoSerif = GoogleFonts.notoSerifDisplay();

  static TextStyle confirmButton = notoSerif.copyWith(
    fontSize: 12,
    color: ThemeColors.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle names = notoSerif.copyWith(
    fontSize: 14,
    color: const Color.fromARGB(255, 194, 130, 11),
    fontWeight: FontWeight.bold,
  );

  static TextStyle declineButton = notoSerif.copyWith(
    fontSize: 14,
    color: ThemeColors.white,
  );

  static TextStyle titleText = notoSerif.copyWith(
    fontSize: 30,
    color: ThemeColors.white,
  );

  static TextStyle historyTitle = notoSerif.copyWith(
    fontSize: 16,
    color: ThemeColors.main,
  );

  static TextStyle subtitle = notoSerif.copyWith(
    fontSize: 14,
    color: ThemeColors.main,
  );

  static TextStyle text = notoSerif.copyWith(
    fontSize: 12,
    color: ThemeColors.greyText,
  );

  static TextStyle addedText = notoSerif.copyWith(
    fontSize: 12,
    color: Colors.lightGreen,
  );

  static TextStyle hintText = notoSerif.copyWith(
    fontSize: 12,
    color: Colors.orange,
  );

  static TextStyle alertText = notoSerif.copyWith(
    fontSize: 12,
    color: ThemeColors.white,
  );

  static TextStyle mainText = notoSerif.copyWith(
    fontSize: 12,
    color: ThemeColors.main,
  );

  static TextStyle mainButton = notoSerif.copyWith(
    fontSize: 18,
    color: ThemeColors.white,
    fontWeight: FontWeight.w500,
  );
}
