import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle bodyRegular = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 16,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
    height: (24 / 16),
  );

  static TextStyle bodyBig = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 18,
    color: AppColors.titleText,
    fontWeight: FontWeight.w400,
    height: (20 / 18),
    letterSpacing: -.02,
  );

  static TextStyle textFieldLabel = bodyRegular.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: (22.4 / 14),
  );

  static TextStyle bottomModalBody = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 14,
    color: AppColors.bottomModalBodyText,
    fontWeight: FontWeight.w400,
    height: (20 / 14),
  );

  static TextStyle textFieldValue = textFieldLabel.copyWith(
    color: AppColors.titleText,
    height: (19.6 / 14),
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodySmall = bodyRegular.copyWith(
    fontSize: 13,
    height: (16 / 13),
    letterSpacing: -.02,
  );

  static TextStyle transactionStatusBody = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 17,
    color: AppColors.titleText,
    fontWeight: FontWeight.w500,
    height: (26 / 14),
    letterSpacing: -0.0006,
  );

  static TextStyle summaryRowTitle = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 14,
    color: AppColors.sunmmaryTitleText,
    fontWeight: FontWeight.w400,
    height: (18.23 / 14),
    letterSpacing: -.00105,
  );

  static TextStyle summaryRowValue = summaryRowTitle.copyWith(
    fontWeight: FontWeight.w600,
    color: AppColors.titleText,
  );

  static TextStyle historyTileTitle = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: (18.23 / 14),
    color: AppColors.titleText,
    letterSpacing: -.005,
  );

  static TextStyle historyTileSubtitle = historyTileTitle.copyWith(
    fontSize: 12,
    height: (15.62 / 12),
  );

  static TextStyle title = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 20,
    color: AppColors.titleText,
    fontWeight: FontWeight.w600,
    height: (26 / 20),
    letterSpacing: -.02,
  );

  static TextStyle authtitle = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 28,
    color: AppColors.titleText,
    fontWeight: FontWeight.w700,
    height: (36 / 28),
    letterSpacing: -.02,
  );

  static TextStyle titleSmall = title.copyWith(
    fontSize: 22,
    height: (28 / 22),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle buttonText = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 18,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    height: (25.2 / 18),
    letterSpacing: -.01,
  );

  static TextStyle tarBarLabel = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 14,
    color: AppColors.titleText,
    fontWeight: FontWeight.w400,
    height: (20 / 14),
  );

  static TextStyle clickableText = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 14,
    color: AppColors.primary,
    fontWeight: FontWeight.w600,
    height: (19.6 / 14),
    letterSpacing: -.01,
  );

  static TextStyle navBarLabel =
      bodyRegular.copyWith(fontSize: 12, height: (14 / 12));

  static TextStyle navBarLabelSelected = navBarLabel.copyWith(
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle amountText = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 20,
    color: AppColors.titleText,
    fontWeight: FontWeight.w700,
    height: (22 / 18),
    letterSpacing: -.02,
  );

  static TextStyle amountTextBig = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 32,
    color: AppColors.titleText,
    fontWeight: FontWeight.w700,
    height: (24 / 32),
  );

  static TextStyle pin = TextStyle(
    fontFamilyFallback: const ['Roboto', 'sans-serif'],
    fontSize: 16,
    color: AppColors.darkBlue.withValues(alpha: .8),
    fontWeight: FontWeight.w900,
    height: (17 / 16),
    letterSpacing: 12,
  );

  static TextStyle appDialog = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBlue,
    letterSpacing: -.04,
    height: (24 / 20),
  );

  static TextStyle avatar = const TextStyle(
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontSize: 18,
    color: AppColors.white,
    fontWeight: FontWeight.w800,
    height: (23.44 / 18),
    letterSpacing: -.03,
  );
}
