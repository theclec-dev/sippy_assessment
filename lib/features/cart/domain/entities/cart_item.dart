import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final int itemId;
  final String id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  final num quantity;
  final String addedBy;
  final num inStock;

  CartItem({
    required this.itemId,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.addedBy,
    required this.inStock,
  });

  @override
  String toString() {
    return 'Product{id: $itemId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, quantity: $quantity}';
  }

  CartItem.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> data)
      : itemId = data.data()['itemId'],
        name = data.data()['name'],
        description = data.data()['description'],
        price = data.data()['price'],
        imageUrl = data.data()['imageUrl'],
        quantity = data.data()['quantity'],
        addedBy = data.data()['addedByName'],
        inStock = data.data()['inStock'],
        id = data.id;
}
