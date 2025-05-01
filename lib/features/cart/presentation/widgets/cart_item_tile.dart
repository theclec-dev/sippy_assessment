import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sippy_assessment/application/theme/app_colors.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/constants/global_variables.dart';
import 'package:sippy_assessment/core/network/shared_cart_service/shared_cart_services.dart';
import 'package:sippy_assessment/core/utils/formatters.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';

import '../../../../core/components/app_text_field.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({
    super.key,
    required this.qtyController,
    required this.cartItem,
  });
  final TextEditingController qtyController;
  final CartItem cartItem;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  final sharedCartServices = SharedCartServices();

  @override
  void initState() {
    widget.qtyController.text = widget.cartItem.quantity.toString();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CartItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cartItem.quantity != widget.cartItem.quantity) {
      widget.qtyController.text = widget.cartItem.quantity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: .24),
                  blurRadius: 2,
                  offset: const Offset(2, 6),
                ),
              ]),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
            leading: Container(
              width: 70,
              height: 400,
              color: AppColors.productsContainerBackground,
              child: const Icon(Icons.photo_outlined),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${widget.cartItem.name} | ${formatCurrency(widget.cartItem.price)}',
                style: AppTextStyles.bodyBig,
              ),
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Added by: ${widget.cartItem.addedBy}',
                  style: AppTextStyles.bodySmall,
                ),
                const Gap(8),
                SizedBox(
                  width: 48,
                  // height: 48,
                  child: AppTextfield(
                    controller: widget.qtyController,
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
                          } else if (number > widget.cartItem.inStock) {
                            number = widget.cartItem.inStock;
                          }
                          widget.qtyController.text = number.toString();
                        }
                        if (value.isEmpty) {
                          widget.qtyController.text = '0';
                        }
                        sharedCartServices.updateQuantity(
                          sessionId: sessionId,
                          itemId: widget.cartItem.id,
                          quantity: int.parse(widget.qtyController.text),
                          userId: userId,
                        );
                      });
                    },
                    onTapOutside: (_) {
                      if (widget.qtyController.text.isEmpty ||
                          widget.qtyController.text == '0') {
                        widget.qtyController.text = '1';
                        setState(() {});
                      }
                      sharedCartServices.updateQuantity(
                        sessionId: sessionId,
                        itemId: widget.cartItem.id,
                        quantity: int.parse(widget.qtyController.text),
                        userId: userId,
                      );
                    },
                    onEditingComplete: () {
                      if (widget.qtyController.text.isEmpty ||
                          widget.qtyController.text == '0') {
                        widget.qtyController.text = '1';
                        setState(() {});
                      }
                      sharedCartServices.updateQuantity(
                        sessionId: sessionId,
                        itemId: widget.cartItem.id,
                        quantity: int.parse(widget.qtyController.text),
                        userId: userId,
                      );
                    },
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          int number = widget.cartItem.quantity.toInt();
                          if (number > 1) {
                            number -= 1;
                          }
                          widget.qtyController.text = number.toString();
                        });
                        sharedCartServices.updateQuantity(
                          sessionId: sessionId,
                          itemId: widget.cartItem.id,
                          quantity: int.parse(widget.qtyController.text),
                          userId: userId,
                        );
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          int number = int.parse(widget.qtyController.text);
                          if (number < widget.cartItem.inStock) {
                            number += 1;
                          }
                          widget.qtyController.text = number.toString();
                        });
                        sharedCartServices.updateQuantity(
                          sessionId: sessionId,
                          itemId: widget.cartItem.id,
                          quantity: int.parse(widget.qtyController.text),
                          userId: userId,
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                top: 8,
                bottom: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatCurrency(
                        widget.cartItem.price * widget.cartItem.quantity),
                    style: AppTextStyles.bodyRegular,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => sharedCartServices.deleteItem(
              sessionId,
              widget.cartItem.id,
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delete,
                size: 16,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
