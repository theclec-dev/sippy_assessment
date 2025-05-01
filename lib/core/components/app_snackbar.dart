import 'package:flutter/material.dart';

import '../../application/theme/app_colors.dart';

void showSnackBar(
  BuildContext context,
  String message, [
  SnackBarType type = SnackBarType.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          type == SnackBarType.error ? AppColors.error : AppColors.primary,
      content: Text(message),
      duration: const Duration(milliseconds: 1300),
    ),
  );
}

enum SnackBarType {
  error,
  success,
}
