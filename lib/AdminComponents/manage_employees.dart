import 'package:flutter/material.dart';
import 'package:potential_potato/Models/employee_model.dart';
import 'package:potential_potato/home.dart';

class ManageEmployeesComponent extends StatefulWidget {
  const ManageEmployeesComponent({super.key, required this.employee});
  final Employee employee;

  @override
  State<ManageEmployeesComponent> createState() =>
      _ManageEmployeesComponentState();
}

class _ManageEmployeesComponentState extends State<ManageEmployeesComponent> {
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
          Text("Manage Employees"),
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
