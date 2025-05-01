import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../application/theme/app_colors.dart';
import '../../application/theme/app_text_styles.dart';

class AppTextfield extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function? validator;
  final String? label;
  final int? minLines;
  final double? borderRadius;
  final int? maxLines;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final Function? onTap;
  final Function? onEditingComplete;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final double? height;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Color? borderSideColor;
  final bool? isPasswordField;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool isFloatingLabel;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final Color? fillColor;
  final InputBorder? errorBorder, disabledBorder, enabledBorder;
  final String? counterText;
  final String obscuringCharacter;
  final List<BoxShadow>? boxShadow;
  final bool autocorrect;
  final TextStyle? counterTextStyle;
  final bool isTopCounter;
  final TextStyle? textStyle;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextAlign textAlign;

  final bool hasShadow;
  final Function(PointerDownEvent)? onTapOutside;

  const AppTextfield({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText,
    this.validator,
    this.minLines,
    this.maxLines,
    this.suffixIcon,
    this.textInputAction,
    this.inputFormatters,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
    this.label,
    this.onEditingComplete,
    this.prefixIcon,
    this.borderRadius,
    this.maxLength,
    this.readOnly,
    this.focusNode,
    this.borderSideColor,
    this.isPasswordField = false,
    this.height = 46,
    this.floatingLabelBehavior,
    this.isFloatingLabel = true,
    this.hintStyle,
    this.border,
    this.fillColor,
    this.errorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.counterText = '',
    this.counterTextStyle,
    this.isTopCounter = true,
    this.obscuringCharacter = '*',
    this.boxShadow,
    this.autocorrect = false,
    this.textStyle,
    this.horizontalPadding,
    this.verticalPadding,
    this.textAlign = TextAlign.start,

    ///If false, boxShadow is ignored
    this.hasShadow = true,
    this.onTapOutside,
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //added this to create a label that sits above the  text field
        //allows the widget to be reused in cases of the flutter default TextField label behaviour
        if ((widget.isFloatingLabel && widget.label != null) ||
            (widget.counterText!.isNotEmpty &&
                widget.counterText != '' &&
                widget.isTopCounter == true)) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.isFloatingLabel && widget.label != null) ...[
                const Gap(12),
                Text(
                  widget.label!,
                  style: AppTextStyles.textFieldLabel,
                )
              ],
              const Spacer(),
              if (widget.counterText!.isNotEmpty &&
                  widget.counterText != '' &&
                  widget.isTopCounter == true)
                Text(
                  widget.counterText!,
                  style: widget.counterTextStyle,
                ),
            ],
          ),
          const SizedBox(
            height: 2,
          )
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            boxShadow: widget.hasShadow
                ? widget.boxShadow ??
                    [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: .24),
                        blurRadius: 2,
                        offset: const Offset(2, 6),
                      ),
                    ]
                : null,
          ),
          height: widget.maxLines == null || widget.minLines == null
              ? widget.height
              : null,
          child: TextFormField(
            // inputFormatters: widget.inputFormatter,
            onTapOutside: widget.onTapOutside ??
                (_) {
                  widget.focusNode?.unfocus();
                },
            focusNode: widget.focusNode,
            onTap: widget.onTap as void Function()?,
            onChanged: widget.onChanged as void Function(String)? ??
                (_) {
                  setState(() {});
                },
            obscureText: widget.obscureText ?? false,
            obscuringCharacter: widget.obscuringCharacter,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //style: TextStyle(fontSize: 12),
            minLines: widget.minLines ?? 1,
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            autocorrect: widget.autocorrect,
            onEditingComplete: widget.onEditingComplete as void Function()?,
            inputFormatters: widget.inputFormatters,
            // == null ? [] : [widget.inputFormatter!],
            textCapitalization: widget.textCapitalization,
            validator: widget.validator as String? Function(String?)?,
            cursorColor: AppColors.titleText,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            style: widget.textStyle ?? AppTextStyles.textFieldValue,
            textAlignVertical: TextAlignVertical.center,
            textAlign: widget.textAlign,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding ?? 14,
                vertical:
                    (widget.height! > 46) ? widget.verticalPadding ?? 12 : 0,
              ),
              errorMaxLines: 4,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: widget.fillColor ?? AppColors.white,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.lightGrey,
                  ),
              prefixIcon: widget.prefixIcon,
              labelText: widget.isFloatingLabel ? null : widget.label,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              // floatingLabelAlignment: ,
              labelStyle: AppTextStyles.bodyRegular,
              border: widget.border ??
                  OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 48),
                    borderSide: BorderSide(
                      color:
                          widget.borderSideColor ?? AppColors.textFieldBorder,
                      width: 1,
                    ),
                  ),
              focusedBorder: widget.border ??
                  OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 48),
                    borderSide: BorderSide(
                      color: widget.borderSideColor ?? AppColors.primary,
                      width: 1,
                    ),
                  ),
              enabledBorder: widget.enabledBorder ??
                  widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 48,
                    ),
                    borderSide: BorderSide(
                      color:
                          widget.borderSideColor ?? AppColors.textFieldBorder,
                      width: 1,
                    ),
                  ),
              disabledBorder: widget.disabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 48),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.borderSideColor ?? AppColors.transparent,
                    ),
                  ),
              errorBorder: widget.errorBorder ??
                  widget.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 48),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.borderSideColor ?? AppColors.error,
                    ),
                  ),
              // focusedErrorBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(widget.borderRadius ?? 30.0)),
              //     borderSide:
              //     const BorderSide(width: 1.5, color: Colors.redAccent)),
              counterText: widget.isTopCounter ? '' : widget.counterText,
              counterStyle:
                  widget.counterTextStyle ?? AppTextStyles.bodyRegular,

              /// Except counter text is added to any field in design
            ),
            maxLength: widget.maxLength,
            readOnly: widget.readOnly ?? false,
          ),
        ),
      ],
    );
  }
}
