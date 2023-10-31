import 'package:flutter/material.dart';
import 'package:potential_potato/Models/employee_model.dart';

import '../home.dart';

class ManageProductsComponent extends StatefulWidget {
  const ManageProductsComponent({super.key, required this.employee});
  final Employee employee;

  @override
  State<ManageProductsComponent> createState() =>
      _ManageProductsComponentState();
}

class _ManageProductsComponentState extends State<ManageProductsComponent> {
  late Employee _employee;
  @override
  void initState() {
    _employee = widget.employee;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text("Manage Products"),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeComponent()));
              },
              child: Text("Home")),
        ],
      )),
    );
  }
}
