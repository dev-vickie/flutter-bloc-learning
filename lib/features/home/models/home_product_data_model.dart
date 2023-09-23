import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDataModel.fromJson(String source) => ProductDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
