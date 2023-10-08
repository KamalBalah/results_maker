import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: AppColors.mainLight,
      primaryColorLight: AppColors.secondLight,
      primaryColorDark: AppColors.thirdLight,
      canvasColor: AppColors.mainLight,
      dividerTheme: const DividerThemeData(
        color: Colors.black54,
      ),
      dialogTheme: DialogTheme(
          backgroundColor: AppColors.mainLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      shadowColor: Colors.grey.withOpacity(0.5),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all<Color>(AppColors.accent)),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.accent,
        ),
        elevation: 0.0,
        centerTitle: true,
        color: AppColors.mainLight,
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.accent,
      ),
      scaffoldBackgroundColor: AppColors.mainLight,
      cardColor: AppColors.mainLight,
      brightness: Brightness.light,
      dividerColor: AppColors.accent.withOpacity(0.1),
      focusColor: AppColors.accent,
      fontFamily: 'SF Arabic Font',
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.accent,
      ),
    );
  }
}
