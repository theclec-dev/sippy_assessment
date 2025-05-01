import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
}