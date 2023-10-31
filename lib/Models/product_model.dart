import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final String category;
  final int inventoryQuantity;
  final DateTime dateAdded;
  final DateTime expirationDate;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.inventoryQuantity,
    required this.dateAdded,
    required this.expirationDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      inventoryQuantity: json['inventoryQuantity'],
      dateAdded: DateTime.parse(json['dateAdded']),
      expirationDate: DateTime.parse(json['expirationDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'inventoryQuantity': inventoryQuantity,
      'dateAdded': dateAdded.toIso8601String(),
      'expirationDate': expirationDate.toIso8601String(),
    };
  }
}
