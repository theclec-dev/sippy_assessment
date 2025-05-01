import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sippy_assessment/application/routes/app_router.dart';
import 'package:sippy_assessment/application/theme/app_colors.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/components/app_button.dart';
import 'package:sippy_assessment/core/components/app_dialog.dart';
import 'package:sippy_assessment/core/components/app_snackbar.dart';
import 'package:sippy_assessment/core/constants/assets.dart';
import 'package:sippy_assessment/core/constants/global_variables.dart';
import 'package:sippy_assessment/core/network/shared_cart_service/shared_cart_services.dart';
import 'package:sippy_assessment/core/utils/formatters.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';
import 'package:sippy_assessment/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:sippy_assessment/features/cart/presentation/widgets/summary_tile.dart';

@RoutePage()
class SharedCartPage extends StatefulWidget {
  const SharedCartPage({super.key});

  @override
  State<SharedCartPage> createState() => _SharedCartPageState();
}

class _SharedCartPageState extends State<SharedCartPage> {
  late final List<TextEditingController> _qtyControllers;
  final sharedCartServices = SharedCartServices();
  bool _isLoading = false;

  @override
  void initState() {
    _qtyControllers =
        List.generate(4, (index) => TextEditingController(text: 1.toString()));
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    _qtyControllers.map((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: SvgPicture.asset(
          logo,
          height: 25,
        ),
      ),
      body: StreamBuilder<List<CartItem>>(
          stream: sharedCartServices.getCartItems(sessionId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading cart items',
                  style: AppTextStyles.bodyRegular,
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No items in the cart',
                  style: AppTextStyles.bodyRegular,
                ),
              );
            }
            final cart = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => CartItemTile(
                        qtyController: _qtyControllers[index],
                        cartItem: cart[index],
                      ),
                      separatorBuilder: (context, index) => const Gap(10),
                      itemCount: cart.length,
                    ),
                  ),
                  const Gap(6),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        SummaryTile(
                          title: 'Subtotal',
                          value: formatCurrency(_subtotal(cart)),
                        ),
                        const Gap(6),
                        SummaryTile(
                          title: 'Shipping',
                          value: formatCurrency(1500),
                        ),
                        const Gap(6),
                        SummaryTile(
                          title: 'Total',
                          value: formatCurrency(_subtotal(cart) + 1500),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  AppButton.primary(
                    isLoading: _isLoading,
                    isActive: !_isLoading,
                    onTap: () async {
                      final response = await showDialog(
                        context: context,
                        builder: (context) => AppDialog(
                          message: 'You are about to check out. Continue?',
                          primaryAction: 'Yes, checkout',
                          secondaryAction: 'No, cancel',
                          onTapPrimary: () {
                            context.pop(true);
                          },
                          onTapSecondary: () {
                            context.pop(false);
                          },
                          hasSecondary: true,
                        ),
                      );
                      if (response) {
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          await sharedCartServices.checkout(
                            sessionId,
                            userName,
                            userId,
                          );
                          _navigateToConfirmation();
                        } catch (e) {
                          if (context.mounted) {
                            showSnackBar(context, 'Error checking out: $e');
                          }
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    text: 'Done Shopping',
                  ),
                  const Gap(12)
                ],
              ),
            );
          }),
    );
  }

  num _subtotal(List<CartItem> cartItems) {
    num subtotal = 0;
    for (var item in cartItems) {
      subtotal += (item.price * item.quantity);
    }
    return subtotal;
  }

  _navigateToConfirmation() {
    context.router.replaceAll([
      const HomeRoute(),
      const ConfirmationRoute(),
    ]);
  }
}
