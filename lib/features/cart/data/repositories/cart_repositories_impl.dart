import 'package:sippy_assessment/features/cart/data/datasources/local_datasources/cart_local_datasource.dart';
import 'package:sippy_assessment/features/cart/data/mappers/cart_item_mapper.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';
import 'package:sippy_assessment/features/cart/domain/repositories/cart_repositories.dart';

class CartRepositoriesImpl implements CartRepository {
  final CartLocalDatasource cartLocalDatasource;

  CartRepositoriesImpl({required this.cartLocalDatasource});

  @override
  Future<List<CartItem>> getCartItems() async {
    final models = await cartLocalDatasource.getCartItems();
    return models.map((model) => CartItemMapper.toEntity(model)).toList();
  }
}
