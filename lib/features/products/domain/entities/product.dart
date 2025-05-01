class Product {
  final int id;
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  final num inStock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.inStock,
  });

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, quantity: $inStock}';
  }
}
