import 'package:flutter/material.dart';
import 'package:potential_potato/Models/employee_model.dart';

class POSComponent extends StatefulWidget {
  const POSComponent({super.key, required this.employee});
  final Employee employee;

  @override
  State<POSComponent> createState() => _POSComponentState();
}

class _POSComponentState extends State<POSComponent> {
  late Employee _employee;
  @override
  void initState() {
    _employee = widget.employee;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
