import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/components/app_button.dart';
import 'package:sippy_assessment/core/constants/assets.dart';

@RoutePage()
class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Your order has been confirmed. Thank you for shopping with\n",
                    style: AppTextStyles.title,
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: SvgPicture.asset(
                        logo,
                        height: 32,
                        width: 12,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            AppButton.primary(
              onTap: () {
                context.pop();
              },
              text: 'Back to Home',
            ),
          ],
        ),
      ),
    );
  }
}
