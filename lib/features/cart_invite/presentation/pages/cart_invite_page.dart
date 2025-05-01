import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sippy_assessment/application/routes/app_router.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/components/app_button.dart';
import 'package:sippy_assessment/core/components/app_snackbar.dart';
import 'package:sippy_assessment/core/components/app_text_field.dart';
import 'package:sippy_assessment/core/constants/assets.dart';
import 'package:sippy_assessment/core/constants/global_variables.dart';
import 'package:sippy_assessment/core/network/shared_cart_service/shared_cart_services.dart';

@RoutePage()
class CartInvitePage extends StatefulWidget {
  const CartInvitePage({super.key});

  @override
  State<CartInvitePage> createState() => _CartInvitePageState();
}

class _CartInvitePageState extends State<CartInvitePage> {
  late final TextEditingController _controller;
  late final TextEditingController _linkController;

  final share = SharePlus.instance;

  @override
  void initState() {
    _controller = TextEditingController();
    _linkController = TextEditingController(text: sessionId);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _linkController.dispose();
    super.dispose();
  }

  bool isLinkGenerated = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: SvgPicture.asset(
          logo,
          height: 25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Enter name to be displayed to friends below to share a cart and start shopping on  ",
                    style: AppTextStyles.bodyBig,
                  ),
                  WidgetSpan(
                    child: SvgPicture.asset(
                      logo,
                      height: 20,
                      width: 12,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ],
              ),
            ),
            const Gap(32),
            AppTextfield(
              controller: _controller,
              textInputType: TextInputType.text,
              label: 'Enter name',
              hintText: 'e.g John Doe',
              onChanged: (_) {
                setState(() {
                  isLinkGenerated = false;
                });
              },
            ),
            if (isLinkGenerated) ...[
              const Gap(16),
              AppTextfield(
                readOnly: true,
                controller: _linkController,
                textInputType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final result = await share.share(
                      ShareParams(
                        text:
                            'Use the code to share my shopping cart:\n${_linkController.text}',
                        subject: 'Join my cart session',
                      ),
                    );
                    if (result.status == ShareResultStatus.success) {
                      if (context.mounted) {
                        showSnackBar(
                          context,
                          'Shared Successfully!',
                          SnackBarType.success,
                        );
                      }
                    }
                    // await Clipboard.setData(
                    //   ClipboardData(text: _linkController.text),
                    // )
                    //     .then((_) {
                    //   if (context.mounted) {
                    //     showSnackBar(
                    //       context,
                    //       'Shared Successfully!',
                    //       SnackBarType.success,
                    //     );
                    //   }
                    // });
                  },
                  icon: const Icon(Icons.share),
                ),
              )
            ],
            const Gap(24),
            AppButton.primary(
              isLoading: isLoading,
              isActive: isActive(isLoading),
              onTap: () async {
                if (!isLinkGenerated) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    final SharedCartServices sharedCartServices =
                        SharedCartServices();
                    _linkController.text =
                        await sharedCartServices.createSession(
                      user.userId,
                      _controller.text,
                    );
                    sessionId = _linkController.text;
                    userName = _controller.text;
                  } catch (e) {
                    if (context.mounted) {
                      showSnackBar(context, 'Error joining session: $e');
                    }
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  setState(() {
                    isLinkGenerated = true;
                    isLoading = false;
                  });
                  return;
                }

                context.pushRoute(const ProductsListRoute());
              },
              text: buttonLabel(),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  String buttonLabel() {
    if (isLinkGenerated) {
      return 'Proceed to products list';
    }
    return 'Create Session';
  }

  bool isActive(bool isLoading) {
    if (isLoading) {
      return false;
    }
    if (_controller.text.isEmpty || _controller.text.length < 3) {
      return false;
    }
    return true;
  }
}
