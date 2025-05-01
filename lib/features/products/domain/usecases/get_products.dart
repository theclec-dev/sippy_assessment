import 'package:sippy_assessment/features/products/domain/entities/product.dart';
import 'package:sippy_assessment/features/products/domain/repositories/products_repositories.dart';

class GetProducts {
  final ProductsRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
