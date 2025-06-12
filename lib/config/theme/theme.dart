import 'package:echo/config/theme/app_palette.dart';
import 'package:echo/config/theme/custom_themes/input_decoration_theme.dart';
import 'package:echo/config/theme/custom_themes/text_theme.dart';
import 'package:echo/config/theme/theme_extension.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppPalette.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Montserrat",
    textTheme: AppTextTheme.lightTextTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
    extensions: [
      AppColorExtension(
        primaryColor: AppPalette.primaryColor,
        secondaryColor: AppPalette.secondaryColor,
        accentColor: AppPalette.accentColor,
        successColor: AppPalette.successColor,
        errorColor: AppPalette.errorColor,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppPalette.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    fontFamily: "Montserrat",
    textTheme: AppTextTheme.darkTExtTheme,
    inputDecorationTheme: AppInputDecorationTheme.darkInputDecorationTheme,
    extensions: [
      AppColorExtension(
        primaryColor: AppPalette.primaryColor,
        secondaryColor: AppPalette.secondaryColor,
        accentColor: AppPalette.accentColor,
        successColor: AppPalette.successColor,
        errorColor: AppPalette.errorColor,
      ),
    ],
  );
}
