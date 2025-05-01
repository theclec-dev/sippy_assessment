import 'package:sippy_assessment/features/products/data/datasources/local_datasources/products_local_datasource.dart';
import 'package:sippy_assessment/features/products/data/mappers/product_mappers.dart';
import 'package:sippy_assessment/features/products/domain/entities/product.dart';
import 'package:sippy_assessment/features/products/domain/repositories/products_repositories.dart';

class ProductsRepositoriesImpl implements ProductsRepository {
  final ProductsLocalDatasource productsLocalDatasource;

  ProductsRepositoriesImpl({required this.productsLocalDatasource});

  @override
  Future<List<Product>> getProducts() async {
    final models =  await productsLocalDatasource.getProducts();
    return models.map((model) => ProductMappers.toEntity(model)).toList();
  }
}
