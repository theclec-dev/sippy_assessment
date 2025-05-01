class CartItemModel {
  final int id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  final num quantity;
  final String addedBy;
  final num inStock;

  CartItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.addedBy,
    required this.inStock,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      quantity: (json['quantity'] as num),
      addedBy: json['addedBy'] as String,
      inStock: (json['inStock'] as num),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'addedBy': addedBy,
      'inStock': inStock,
    };
  }
}
