import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sippy_assessment/application/theme/theme_provider.dart';
import 'package:sippy_assessment/core/constants/global_variables.dart';
import 'package:sippy_assessment/core/network/shared_cart_service/shared_cart_services.dart';
import 'package:sippy_assessment/core/utils/service_locator.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';
import 'package:sippy_assessment/features/cart/presentation/providers/cart_provider.dart';
import 'package:sippy_assessment/features/products/presentation/providers/products_provider.dart';
import 'package:sippy_assessment/firebase_options.dart';

import 'application/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsList(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        StreamProvider<List<CartItem>>(
          create: (_) => SharedCartServices().getCartItems(sessionId),
          initialData: const [],
          catchError: (_, __) => [],
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        theme: themeProvider.currentTheme,
        debugShowCheckedModeBanner: false,
        title: 'Sippy Assessment',
        themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
