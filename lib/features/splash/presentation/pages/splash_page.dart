import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sippy_assessment/application/routes/app_router.dart';
import 'package:sippy_assessment/core/constants/assets.dart';
import 'package:sippy_assessment/core/constants/global_variables.dart';
import 'package:sippy_assessment/core/network/auth_service/auth_service.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService _authService = AuthService();
  void _navigate() async {
    final response = await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      _authService.signIn(),
    ]);
    final user = response[1] as User;
    _updateUserId(user.uid);
    _toHomePage();
  }

  void _updateUserId(String userId) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUserId(userId);
  }

  void _toHomePage() {
    context.replaceRoute(const HomeRoute());
  }

  @override
  void initState() {
    super.initState();

    _navigate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: FadeInDown(
          duration: const Duration(milliseconds: 2700),
          child: Center(
            child: SvgPicture.asset(logo),
          ),
        ),
      ),
    );
  }
}
