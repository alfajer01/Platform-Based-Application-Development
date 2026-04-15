// ignore_for_file: file_names

import 'Variant.dart';

class Product {
  final int id;
  final String name;
  final int price;
  final String description;
  final List<Variant> variants;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final variantList = (json['variants'] as List<dynamic>? ?? [])
        .map((item) => Variant.fromJson(item as Map<String, dynamic>))
        .toList();

    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: (json['description'] ?? '') as String,
      variants: variantList,
    );
  }
}
