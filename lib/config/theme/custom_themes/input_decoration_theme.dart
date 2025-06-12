import 'package:echo/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

abstract class AppInputDecorationTheme {
  static final InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    iconColor: Colors.grey,
    filled: true,
    fillColor: Colors.grey.shade600.withAlpha(50),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppPalette.primaryColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );

  static final InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    iconColor: Colors.grey,
    filled: true,
    fillColor: Colors.grey.shade600.withAlpha(50),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade600,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppPalette.secondaryColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );
}
