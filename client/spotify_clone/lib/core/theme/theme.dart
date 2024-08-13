import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    chipTheme: ChipThemeData(
      color: WidgetStateProperty.all(AppPallete.gradient1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(),
      border: _border(),
      focusedBorder: _border(AppPallete.gradient1),
      errorBorder: _border(AppPallete.errorColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPallete.backgroundColor,
      selectedItemColor: AppPallete.whiteColor,
      unselectedItemColor: AppPallete.greyColor,
    ),
  );

  static final darkTheme = ThemeData.dark()
      .copyWith(scaffoldBackgroundColor: AppPallete.backgroundColor);
}
