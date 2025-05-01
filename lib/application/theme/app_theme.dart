import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? darkTheme : lightTheme;
  }

  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    dividerColor: AppColors.verticalDivider,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: AppColors.background,
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
    ),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(),
    // fontFamily: 'Raleway',
    useMaterial3: false,
  );

  // static final defaultPinTheme = PinTheme(
  //   width: 48.w,
  //   height: 49.h,
  //   textStyle: AppTextStyles.title.copyWith(
  //     fontWeight: FontWeight.w400,
  //     fontSize: 32.sp,
  //     height: (48 / 32).sp,
  //   ),
  //   decoration: BoxDecoration(
  //     color: AppColors.white,
  //     borderRadius: BorderRadius.circular(8.r),
  //     border: Border.all(
  //       color: AppColors.pinBorder,
  //     ),
  //   ),
  // );
}
