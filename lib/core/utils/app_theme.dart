import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: Colors.black,
    canvasColor: AppColors.secondaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: AppColors.primaryColor,
    ),
  );
}
