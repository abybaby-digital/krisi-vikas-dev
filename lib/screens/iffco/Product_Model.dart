class Product {
  final int id;
  final String productImage;
  final String productName;

  Product({
    required this.id,
    required this.productImage,
    required this.productName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productImage: json['product_image'],
      productName: json['product_name'],
    );
  }
}