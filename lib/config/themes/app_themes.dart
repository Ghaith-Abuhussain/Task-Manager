import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      fontFamily: 'Raleway',
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: CustomColors.primaryColor,
        secondary: CustomColors.darkBlue,
        background: CustomColors.background,

      ),
      iconTheme: const IconThemeData(color: CustomColors.darkBlue,)
    );
  }
}
