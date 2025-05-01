import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../application/theme/app_colors.dart';
import '../../application/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.height,
    this.width,
    this.text,
    this.textStyle,
    this.backgroundColor,
    required this.isPrimary,
    required this.isLoading,
    this.isActive = true,
    this.hasSuffix = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.onTap,
    this.isFullWidth = true,
    this.padding,
    this.gradient,
    this.child,
  });
  final double? height;
  final double? width;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool isPrimary;
  final bool isLoading;
  final bool isActive;
  final bool hasSuffix;
  final String? suffixIcon;
  final String? prefixIcon;
  final Function() onTap;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final Gradient? gradient;
  final Widget? child;

  factory AppButton.primary({
    double? height,
    double? width,
    String? text,
    TextStyle? textStyle,
    Color? backgroundColor,
    bool isLoading = false,
    bool isActive = true,
    required Function() onTap,
    String? suffixIcon,
    String? prefixIcon,
    bool hasSuffix = false,
    bool isFullWidth = true,
    EdgeInsets? padding,
    Widget? child,
    Gradient? gradient,
  }) =>
      AppButton(
        text: text,
        textStyle: textStyle,
        isPrimary: true,
        isLoading: isLoading,
        backgroundColor: backgroundColor,
        height: height,
        width: width,
        onTap: onTap,
        isActive: isActive,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hasSuffix: hasSuffix,
        isFullWidth: isFullWidth,
        padding: padding,
        gradient: gradient,
        child: child,
      );

  factory AppButton.secondary({
    double? height,
    double? width,
    String? text,
    TextStyle? textStyle,
    Color? backgroundColor,
    bool isLoading = false,
    bool isActive = true,
    required Function() onTap,
    String? suffixIcon,
    String? prefixIcon,
    bool hasSuffix = false,
    bool isFullWidth = true,
    EdgeInsets? padding,
    Gradient? gradient,
    Widget? child,
  }) =>
      AppButton(
        text: text,
        textStyle: textStyle,
        isPrimary: false,
        isLoading: isLoading,
        backgroundColor: backgroundColor,
        height: height,
        width: width,
        onTap: onTap,
        isActive: isActive,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hasSuffix: hasSuffix,
        isFullWidth: isFullWidth,
        padding: padding,
        gradient: gradient,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    double setHeight = height ?? 48;
    double? setWidth =
        width ?? (isFullWidth ? MediaQuery.sizeOf(context).width : null);

    return GestureDetector(
      onTap: () {
        if (isActive) {
          onTap();
        }
      },
      child: SizedBox(
        width: setWidth,
        height: setHeight,
        child: Stack(
          children: [
            Container(
              width: setWidth,
              height: setHeight,
              padding: setHeight < 56 ? padding : const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive
                    ? backgroundColor ??
                        (isPrimary ? AppColors.primary : AppColors.white)
                    : AppColors.defaultGrey,
                borderRadius: BorderRadius.circular(48),
                border: const Border(
                  right: BorderSide(
                    width: 4,
                    color: AppColors.black,
                  ),
                  left: BorderSide(
                    width: 1,
                    color: AppColors.black,
                  ),
                  top: BorderSide(
                    width: 1,
                    color: AppColors.black,
                  ),
                  bottom: BorderSide(
                    width: 6,
                    color: AppColors.black,
                  ),
                ),
                boxShadow: isPrimary
                    ? null
                    : [
                        BoxShadow(
                          color: const Color(0xFFF4F5FA).withValues(alpha: 0.6),
                          offset: const Offset(0, -3),
                          blurRadius: 6,
                        ),
                      ],
              ),
              // alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefixIcon != null) ...[
                      SvgPicture.asset(prefixIcon!),
                      const Gap(10),
                    ],
                    !isLoading
                        ? child != null
                            ? child!
                            : Text(
                                text ?? '',
                                style: textStyle ??
                                    (isPrimary
                                        ? AppTextStyles.buttonText
                                        : AppTextStyles.buttonText
                                            .copyWith(color: AppColors.blue)),
                              )
                        : Container(
                            width: setHeight - 10,
                            height: setHeight - 10,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 2,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Container(
              width: setWidth,
              height: setHeight,
              decoration: BoxDecoration(
                gradient: gradient,
              ),
            )
          ],
        ),
      ),
    );
  }
}
