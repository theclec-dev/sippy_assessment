import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';
import 'package:sippy_assessment/features/cart/domain/repositories/cart_repositories.dart';

class GetCart {
  final CartRepository repository;

  GetCart(this.repository);

  Future<List<CartItem>> call() async {
    return await repository.getCartItems();
  }
}
