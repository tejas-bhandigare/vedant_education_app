class Product {
  final String id;
  final String name;
  final double price;
  final String image;

  final String category;
  final String subCategory;
  final String description;

  int quantity; // for cart

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.subCategory,
    required this.description,
    this.quantity = 1,
  });

  /// Convert object to Map (for database / Supabase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'category': category,
      'subCategory': subCategory,
      'description': description,
      'quantity': quantity,
    };
  }

  /// Create object from Map (Supabase / JSON safe)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] ?? 0.0).toDouble(),
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 1,
    );
  }

  /// For updating quantity safely
  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    String? category,
    String? subCategory,
    String? description,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }
}



// class Product {
//   final String id;
//   final String name;
//   final double price;
//   final String image;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.image,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//       'image': image,
//     };
//   }
//
//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       name: map['name'],
//       price: map['price'],
//       image: map['image'] ?? '',
//     );
//   }
// }
