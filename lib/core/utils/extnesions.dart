import 'package:echo/config/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtensions on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  ThemeData get theme => Theme.of(this);
}

extension AppThemeExtension on ThemeData {
  AppColorExtension get appColors => extension<AppColorExtension>()!;
}

extension DateTimeExtensions on DateTime {
  String formattedDate() {
    return DateFormat('MMMM d, yyyy').format(this);
  }
}