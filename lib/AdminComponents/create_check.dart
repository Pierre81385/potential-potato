import 'package:flutter/material.dart';
import 'package:potential_potato/Models/employee_model.dart';

import '../Models/check_model.dart';

class CheckComponent extends StatefulWidget {
  const CheckComponent({super.key, required this.employee});
  final Employee employee;
  @override
  State<CheckComponent> createState() => _CheckComponentState();
}

class _CheckComponentState extends State<CheckComponent> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
