import 'package:auto_route/auto_route.dart';
import 'package:sippy_assessment/features/cart/presentation/pages/shared_cart_page.dart';
import 'package:sippy_assessment/features/cart_invite/presentation/pages/cart_invite_page.dart';
import 'package:sippy_assessment/features/cart_invite/presentation/pages/invite_landing_page.dart';
import 'package:sippy_assessment/features/confirmation/presentation/pages/confirmation_page.dart';
import 'package:sippy_assessment/features/home/presentation/pages/home_page.dart';
import 'package:sippy_assessment/features/products/presentation/pages/products_list_page.dart';
import 'package:sippy_assessment/features/splash/presentation/pages/splash_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CartInviteRoute.page),
        AutoRoute(page: InviteLandingRoute.page),
        AutoRoute(page: ConfirmationRoute.page),
        AutoRoute(page: SharedCartRoute.page),
        AutoRoute(page: ProductsListRoute.page),
      ];
}
