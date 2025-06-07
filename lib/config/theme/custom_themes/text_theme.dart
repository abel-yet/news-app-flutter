import 'package:flutter/material.dart';

abstract class AppTextTheme {
  static TextTheme lightTextTheme = ThemeData.light().textTheme.copyWith(
    bodyMedium: TextStyle(
      color: Colors.black,
    ),
  );

  static TextTheme darkTExtTheme = ThemeData.dark().textTheme.copyWith(
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
  );
}
