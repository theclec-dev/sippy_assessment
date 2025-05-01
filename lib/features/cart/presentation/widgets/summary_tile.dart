import 'package:flutter/material.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyRegular,
        ),
        Text(
          value,
          style: AppTextStyles.bodyBig.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
