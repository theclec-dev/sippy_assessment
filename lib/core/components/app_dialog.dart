import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../application/theme/app_colors.dart';
import '../../application/theme/app_text_styles.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.message,
    required this.primaryAction,
    this.secondaryAction,
    this.onTapPrimary,
    this.onTapSecondary,
    this.hasSecondary = true,
  });
  final String message;
  final String primaryAction;
  final String? secondaryAction;
  final Function()? onTapPrimary;
  final Function()? onTapSecondary;
  final bool hasSecondary;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // margin: EdgeInsets.symmetric(
        //   horizontal: 24.w,
        // ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 25,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: AppTextStyles.appDialog,
              textAlign: TextAlign.center,
            ),
            const Gap(27),
            AppButton.primary(
              text: primaryAction,
              onTap: onTapPrimary ?? () {},
            ),
            if (hasSecondary) ...[
              const Gap(12),
              AppButton.secondary(
                text: secondaryAction ?? '',
                onTap: onTapSecondary ?? () {},
                backgroundColor: AppColors.secondaryButtonGrey,
                textStyle:
                    AppTextStyles.buttonText.copyWith(color: AppColors.black),
              )
            ],
          ],
        ),
      ),
    );
  }
}
