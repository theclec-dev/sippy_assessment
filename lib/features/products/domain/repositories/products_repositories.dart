import 'package:sippy_assessment/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProducts();
}