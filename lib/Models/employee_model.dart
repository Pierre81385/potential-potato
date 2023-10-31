import 'dart:convert';

List<String> EmployeeRole = [
  "owner",
  "generalManager",
  "bohManager",
  "fohManager",
  "barManager",
  "bartender",
  "barBack",
  "server",
  "foodRunner",
  "headChef",
  "chef",
  "prepCook",
  "dishwasher",
  "bohTraining",
  "fohTraining",
  "none"
];

class Employee {
  final String EmployeeId;
  final String name;
  final String email;
  final String phoneNumber;
  final List<String> role;

  Employee({
    required this.EmployeeId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      EmployeeId: json['EmployeeId'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: [json['role']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmployeeId': EmployeeId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
