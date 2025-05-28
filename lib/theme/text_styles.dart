import 'package:flutter/material.dart';
import 'theme_colors.dart';

class TextStyles {
  static const String _fontFamily = 'NotoSerifDisplay';

  static TextStyle confirmButton = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: ThemeColors.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle names = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    color: Color.fromARGB(255, 194, 130, 11),
    fontWeight: FontWeight.bold,
  );

  static TextStyle declineButton = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    color: ThemeColors.white,
  );

  static TextStyle titleText = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 30,
    color: ThemeColors.white,
  );

  static TextStyle historyTitle = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    color: ThemeColors.main,
  );

  static TextStyle subtitle = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    color: ThemeColors.main,
  );

  static TextStyle text = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: ThemeColors.greyText,
  );

  static TextStyle addedText = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: Colors.lightGreen,
  );

  static TextStyle hintText = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: Colors.orange,
  );

  static TextStyle alertText = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: ThemeColors.white,
  );

  static TextStyle mainText = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    color: ThemeColors.main,
  );

  static TextStyle mainButton = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    color: ThemeColors.white,
    fontWeight: FontWeight.w500,
  );
}
