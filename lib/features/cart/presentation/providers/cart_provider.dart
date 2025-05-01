import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:sippy_assessment/core/utils/service_locator.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';
import 'package:sippy_assessment/features/cart/domain/usecases/get_cart.dart';
import 'package:sippy_assessment/features/products/domain/entities/product.dart';

final usecase = getIt<GetCart>();

class CartProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  bool isInCart(Product item) {
    return _items.any((cartItem) => cartItem.itemId == item.id);
  }

  get size => _items.length;

  CartItem getItemById(int id) {
    return _items.firstWhere((item) => item.itemId == id);
  }

  void addItem(Product item, int quantity) {
    _items.add(
      CartItem(
        itemId: item.id,
        name: item.name,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: quantity,
        addedBy: 'Me',
        inStock: item.inStock,
        id: item.id.toString(),
      ),
    );
    notifyListeners();
  }

  // void toggleItem(CartItem item) {
  //   item.toggle();
  //   notifyListeners();
  // }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateItem(CartItem item, num quantity) {
    final index =
        _items.indexWhere((cartItem) => cartItem.itemId == item.itemId);
    if (index != -1) {
      _items[index] = CartItem(
        itemId: item.itemId,
        name: item.name,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        quantity: quantity,
        addedBy: 'Me',
        inStock: item.inStock,
        id: item.id.toString(),
      );
      notifyListeners();
    }
  }
}
