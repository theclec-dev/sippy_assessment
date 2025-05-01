import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:sippy_assessment/application/theme/app_colors.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/components/app_button.dart';
import 'package:sippy_assessment/core/components/app_text_field.dart';
import 'package:sippy_assessment/features/products/domain/entities/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.controller,
    required this.product,
    this.inCart = false,
    this.isLoading = false,
    required this.onTapPrimary,
    
  });

  final TextEditingController controller;
  final Product product;
  final bool inCart;
  final bool isLoading;
  final Function() onTapPrimary;
//   final bool isUpdated;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.product.inStock == 0) {
        widget.controller.text = '0';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.productsContainerBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            child: Icon(Icons.image),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.product.name,
                  style: AppTextStyles.bodyBig,
                ),
                Text(
                  '₦${widget.product.price}',
                  style: AppTextStyles.bodySmall,
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: widget.inCart
                          ? null
                          : () {
                              setState(() {
                                int number = int.parse(widget.controller.text);
                                if (number > 1) {
                                  number -= 1;
                                }
                                widget.controller.text = number.toString();
                              });
                            },
                      color: widget.inCart
                          ? AppColors.lightGrey
                          : AppColors.primary,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Expanded(
                      child: AppTextfield(
                        controller: widget.controller,
                        hasShadow: false,
                        height: 30,
                        maxLength: 2,
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              num number = int.parse(value);
                              if (number < 1) {
                                number = 1;
                              } else if (number > widget.product.inStock) {
                                number = widget.product.inStock;
                              }
                              widget.controller.text = number.toString();
                            }
                            if (value.isEmpty) {
                              widget.controller.text = '0';
                            }
                          });
                        },
                        onTapOutside: (_) {
                          if (widget.controller.text.isEmpty ||
                              widget.controller.text == '0') {
                            widget.controller.text = '1';
                            setState(() {});
                          }
                        },
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.inCart
                          ? null
                          : () {
                              setState(() {
                                int number = int.parse(widget.controller.text);
                                if (number < widget.product.inStock) {
                                  number += 1;
                                }
                                widget.controller.text = number.toString();
                              });
                            },
                      color: widget.inCart
                          ? AppColors.lightGrey
                          : AppColors.primary,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                const Gap(14),
                AppButton.primary(
                  isLoading: widget.isLoading,
                  isActive: widget.controller.text.isNotEmpty &&
                      int.parse(widget.controller.text) > 0 && !widget.isLoading,
                  backgroundColor:
                      widget.inCart ? AppColors.red : AppColors.primary,
                  onTap: widget.onTapPrimary,
                  text: widget.controller.text == '0'
                      ? 'Out of Stock'
                      : widget.inCart
                          ? 'Remove Item'
                          : 'Add to Cart',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
