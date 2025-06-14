import 'package:dio/dio.dart';
import 'package:echo/config/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

String getDioErrorMessage(DioException dioException) {
  switch (dioException.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return "Connection timeout";
    case DioExceptionType.connectionError:
      return "No internet connection";
    case DioExceptionType.badResponse:
      final statusCode = dioException.response?.statusCode;
      switch (statusCode) {
        case 400:
          return "We couldn't understand that request. Please check and try again.";
        case 403:
          return "You've reached your daily limit. Try again after 00:00 UTC.";
        case 429:
          return "You're sending requests too fast. Please slow down and retry.";
        case 500:
          return "Something went wrong on our end. Please try again soon.";
        case 503:
          return "We're offline for maintenance. Please check back in a few minutes.";
        default:
          return "Oops something went wrong";
      }
    default:
      return "Oops omething went wrong";
  }
}

Widget verticalSpace(double value) {
  return SizedBox(height: value);
}

Widget horizontalSpace(double value) {
  return SizedBox(width: value);
}

Widget shimmerContainer({
  required double height,
  required double width,
  double? borderRadius,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withAlpha(30),
    highlightColor: Colors.grey.shade200.withAlpha(30),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius) : null,
      ),
    ),
  );
}

SnackBar buildSnackbar({
  required String message,
  bool isError = false,
}) {
  return SnackBar(
    backgroundColor: isError ? AppPalette.errorColor : AppPalette.successColor,
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
