// ignore_for_file: file_names

class Variant {
  final int id;
  final int productId;
  final String name;
  final int additionalPrice;

  const Variant({
    required this.id,
    required this.productId,
    required this.name,
    required this.additionalPrice,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      name: json['name'] as String,
      additionalPrice: json['additional_price'] as int,
    );
  }
}
