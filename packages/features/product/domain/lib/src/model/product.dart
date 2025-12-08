class Product {
  final int id;
  final String? name;
  final String? description;
  final int? price;
  final int? stock;
  final List<String>? imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrls,
  });
}
