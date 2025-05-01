import 'package:sippy_assessment/features/products/data/models/product_model.dart';

abstract class ProductsLocalDatasource {
  Future<List<ProductModel>> getProducts();
}

class ProductsLocalDatasourceImpl implements ProductsLocalDatasource {
  @override
  Future<List<ProductModel>> getProducts() async {
    // Simulate a delay for fetching products from local storage
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      20,
      (index) => ProductModel(
        id: index,
        name: 'Product $index',
        description: 'This is product number $index',
        price: index == 0
            ? 100
            : index % 2 == 0
                ? index * 100 ^ (index / 2).toInt()
                : index * 150,
        imageUrl: 'https://placehold.co/200x200',
        inStock: randomNumbers[index],
      ),
    );
  }
}

final List<int> randomNumbers = [
  42,
  7,
  88,
  0,
  56,
  29,
  73,
  13,
  91,
  37,
  64,
  28,
  55,
  99,
  18,
  5,
  61,
  82,
  44,
  16,
];
