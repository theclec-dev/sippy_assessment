import 'package:sippy_assessment/features/products/data/models/product_model.dart';
import 'package:sippy_assessment/features/products/domain/entities/product.dart';

class ProductMappers {
  static Product toEntity(ProductModel model) => Product(
        id: model.id,
        name: model.name,
        description: model.description,
        price: model.price,
        imageUrl: model.imageUrl,
        inStock: model.inStock,
      );
}
