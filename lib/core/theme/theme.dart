import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Resusable Border color
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
    ),
    // dark color for entire app
    scaffoldBackgroundColor: AppPalette.backgroundColor,

    // For Decoration of Input fields
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2),
    ),

    chipTheme: const ChipThemeData(
      side: BorderSide.none,
      color: WidgetStatePropertyAll(
        AppPalette.backgroundColor,
      ),
    ),
  );
}
