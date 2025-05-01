import 'package:sippy_assessment/features/cart/data/models/cart_item_model.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';

class CartItemMapper {
  static CartItem toEntity(CartItemModel model) => CartItem(
        itemId: model.id,
        name: model.name,
        description: model.description,
        price: model.price,
        imageUrl: model.imageUrl,
        quantity: model.quantity,
        addedBy: model.addedBy,
        inStock: model.inStock,
        id: model.id.toString(),
      );
}
