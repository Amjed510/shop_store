class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? salePrice;
  final String imageUrl;
  final String category;
  final double rating;
  final bool isOnSale;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.salePrice,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.isOnSale,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      salePrice: json['salePrice']?.toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      isOnSale: json['isOnSale'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
      'isOnSale': isOnSale,
      'images': images,
    };
  }
}
