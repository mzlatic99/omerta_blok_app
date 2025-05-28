import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'theme_colors.dart';

class AppThemes {
  static ThemeData primary({bool isDark = false}) => ThemeData(
    useMaterial3: true,
    primaryColor: ThemeColors.greyText,
    scaffoldBackgroundColor: ThemeColors.main,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSwatch(backgroundColor: ThemeColors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ThemeColors.greyText,
      extendedSizeConstraints: BoxConstraints(minWidth: 100, minHeight: 20),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.orangeAccent[200],
      titleTextStyle: TextStyles.titleText.copyWith(
        color: const Color.fromARGB(255, 66, 43, 0),
      ),
      elevation: 4,
      shadowColor: Colors.amber,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.hintText,
      contentPadding: const EdgeInsets.all(15),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeColors.primary, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeColors.main, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeColors.primary,
      selectionColor: ThemeColors.white,
    ),
  );
}
