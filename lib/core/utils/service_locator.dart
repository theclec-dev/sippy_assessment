import 'package:get_it/get_it.dart';
import 'package:sippy_assessment/features/cart/data/datasources/local_datasources/cart_local_datasource.dart';
import 'package:sippy_assessment/features/cart/data/repositories/cart_repositories_impl.dart';
import 'package:sippy_assessment/features/cart/domain/repositories/cart_repositories.dart';
import 'package:sippy_assessment/features/cart/domain/usecases/get_cart.dart';
import 'package:sippy_assessment/features/products/data/datasources/local_datasources/products_local_datasource.dart';
import 'package:sippy_assessment/features/products/data/repositories/products_repositories_impl.dart';
import 'package:sippy_assessment/features/products/domain/repositories/products_repositories.dart';
import 'package:sippy_assessment/features/products/domain/usecases/get_products.dart';

// Import your ApiService

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ProductsLocalDatasource>(
      () => ProductsLocalDatasourceImpl());

  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoriesImpl(
        productsLocalDatasource: getIt<ProductsLocalDatasource>()),
  );

  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(getIt<ProductsRepository>()),
  );

  getIt.registerLazySingleton<CartLocalDatasource>(
    () => CartLocalDatasourceImpl(),
  );

  getIt.registerLazySingleton<CartRepository>(
    () =>
        CartRepositoriesImpl(cartLocalDatasource: getIt<CartLocalDatasource>()),
  );

  getIt.registerLazySingleton<GetCart>(
    () => GetCart(getIt<CartRepository>()),
  );

  // Register other services and repositories as needed
  // getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
}
