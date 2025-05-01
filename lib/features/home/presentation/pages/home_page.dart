import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sippy_assessment/application/routes/app_router.dart';
import 'package:sippy_assessment/application/theme/app_text_styles.dart';
import 'package:sippy_assessment/core/components/app_button.dart';
import 'package:sippy_assessment/core/components/app_snackbar.dart';
import 'package:sippy_assessment/core/constants/assets.dart';
  
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          logo,
          // width: 25,
          height: 25,
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add_circle_outline_outlined),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Existing Sessions',
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(
                      'Cart with Brendan',
                      style: AppTextStyles.bodyBig,
                    ),
                    subtitle: Text(
                      'Last updated: 22/12/2025',
                      style: AppTextStyles.bodySmall,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            const Gap(12),
            AppButton.primary(
              onTap: () async {
                try {
                  context.pushRoute(const CartInviteRoute());
                } catch (e) {
                  showSnackBar(context, 'Error creating session: $e');
                }
              },
              text: 'Start new Session',
            ),
            const Gap(6),
            const Text('or'),
            const Gap(6),
            AppButton.primary(
              onTap: () {
                context.pushRoute(const InviteLandingRoute());
              },
              text: 'Join a Session',
            ),
          ],
        ),
      ),
    );
  }
}
