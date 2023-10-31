import './product_model.dart';
import './time_model.dart';
import 'dart:convert';

class Guest {
  final int table;
  final int seatPosition;
  final List<Product> products;
  final DateTime date;
  final TimeOfDay time;

  Guest({
    required this.table,
    required this.seatPosition,
    required this.products,
    required this.date,
    required this.time,
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      table: json['table'],
      seatPosition: json['seatPosition'],
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e))
          .toList(),
      date: DateTime.parse(json['date']),
      time: TimeOfDay.fromJson(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table': table,
      'seatPosition': seatPosition,
      'products': products.map((product) => product.toJson()).toList(),
      'date': date.toIso8601String(),
      'time': time.toJson(),
    };
  }
}
