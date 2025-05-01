import 'package:sippy_assessment/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDatasource {
  Future<List<CartItemModel>> getCartItems();
}

class CartLocalDatasourceImpl implements CartLocalDatasource {
  @override
  Future<List<CartItemModel>> getCartItems() async {
    // Simulate a delay for fetching products from local storage
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }
}
