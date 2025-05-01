import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sippy_assessment/application/routes/app_router.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/components/app_button.dart';
import 'package:sippy_assessment/core/components/app_dialog.dart';
import 'package:sippy_assessment/core/components/app_snackbar.dart';
import 'package:sippy_assessment/core/components/app_text_field.dart';
import 'package:sippy_assessment/core/constants/assets.dart';
import 'package:sippy_assessment/core/constants/global_variables.dart';
import 'package:sippy_assessment/core/network/shared_cart_service/shared_cart_services.dart';

@RoutePage()
class InviteLandingPage extends StatefulWidget {
  const InviteLandingPage({super.key});

  @override
  State<InviteLandingPage> createState() => _InviteLandingPageState();
}

class _InviteLandingPageState extends State<InviteLandingPage> {
  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  bool isLoading = false;

  @override
  void initState() {
    _idController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        "Enter session ID and name to be displayed to friends below to join a shared cart and start shopping on  ",
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
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            AppTextfield(
              controller: _idController,
              textInputType: TextInputType.text,
              label: 'Enter ID',
              hintText: 'e.g IFFIIayRSVkSjlnAHOYd',
              onChanged: (_) {
                setState(() {});
              },
            ),
            const Gap(16),
            AppTextfield(
              // readOnly: true,
              controller: _nameController,
              textInputType: TextInputType.text,
              label: 'Enter name',
              hintText: 'e.g John Doe',
              onChanged: (_) {
                setState(() {});
              },
            ),
            const Gap(24),
            AppButton.primary(
              isActive: isActive(false),
              isLoading: isLoading,
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  final userId =
                      Provider.of<UserProvider>(context, listen: false).userId;
                  final sharedCartService = SharedCartServices();

                  final name = await sharedCartService.joinSession(
                    _idController.text,
                    userId,
                    _nameController.text,
                  );
                  final response = await _showDialog(name);

                  if (!response) {
                    sharedCartService.checkout(
                      _idController.text,
                      _nameController.text,
                      userId,
                    );

                    return;
                  }
                  sessionId = _idController.text;
                  userName = _nameController.text;
                  _navigateToProductsList();
                } catch (e) {
                  if (context.mounted) {
                    showSnackBar(context, 'Error joining session: $e');
                  }
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              text: buttonLabel(),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDialog(String name) async {
    return await showDialog(
      context: context,
      builder: (context) => AppDialog(
        message: 'You are about to join a cart created by $name. Continue?',
        primaryAction: 'Yes, join session',
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
  }

  void _navigateToProductsList() {
    context.pushRoute(const ProductsListRoute());
  }

  String buttonLabel() {
    return 'Join Session';
  }

  bool isActive(bool isLoading) {
    if (isLoading) {
      return false;
    }
    if ((_idController.text.isEmpty || _idController.text.length < 3) &&
        (_nameController.text.isEmpty || _nameController.text.length < 3)) {
      return false;
    }
    return true;
  }
}
