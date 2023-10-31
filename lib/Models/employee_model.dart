import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

List<String> employeeRole = [
  "Owner",
  "General Manager",
  "BOH Manager",
  "FOH Manager",
  "Bar Manager",
  "Bartender",
  "Barback",
  "Server",
  "Food Runner",
  "Head Chef",
  "Chef",
  "Prep COok",
  "Dish",
  "Training",
  "none"
];

class Employee {
  final String employeeId;
  final String name;
  final String email;
  final String role;

  Employee({
    required this.employeeId,
    required this.name,
    required this.email,
    required this.role,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['employeeId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory Employee.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Employee(
        employeeId: data?['employeeId'],
        name: data?['name'],
        email: data?['email'],
        role: data?['role']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (employeeId != null) 'employeeId': employeeId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
    };
  }
}
