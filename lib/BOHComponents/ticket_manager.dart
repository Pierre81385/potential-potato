import 'package:flutter/material.dart';
import 'package:potential_potato/Models/employee_model.dart';

class TicketManagerComponent extends StatefulWidget {
  const TicketManagerComponent({super.key, required this.employee});
  final Employee employee;

  @override
  State<TicketManagerComponent> createState() => _TicketManagerComponentState();
}

class _TicketManagerComponentState extends State<TicketManagerComponent> {
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
