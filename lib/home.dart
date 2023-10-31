import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:potential_potato/AdminComponents/manage_employees.dart';
import 'package:potential_potato/AdminComponents/manage_products.dart';
import 'package:potential_potato/AuthComponents/login.dart';
import 'package:potential_potato/BOHComponents/ticket_manager.dart';
import 'package:potential_potato/FOHComponents/point_of_sale.dart';
import 'package:potential_potato/Models/employee_model.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  String userStatus = "User not authenticated.";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Map<String, dynamic> jsonData = {};
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  late Employee _employee =
      Employee(employeeId: "", name: "", email: "", role: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final docRef = firestore.collection("Employees").doc(_currentUser?.uid);
    docRef.get().then(
      (DocumentSnapshot<Map<String, dynamic>> doc) {
        setState(() {
          _employee = Employee.fromFirestore(doc, null);
        });
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('- ${_employee.role} -'),
            Text('Welcome, ${_employee.name}!'),
            _employee.role == "Owner" || _employee.role == "General Manager"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManageEmployeesComponent(
                                          employee: _employee,
                                        )));
                          },
                          child: Text("Employee Manager")),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManageProductsComponent(
                                          employee: _employee,
                                        )));
                          },
                          child: Text("Product Manager")),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => POSComponent(
                                          employee: _employee,
                                        )));
                          },
                          child: Text("FOH Manager")),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TicketManagerComponent(
                                          employee: _employee,
                                        )));
                          },
                          child: Text("BOH Manager")),
                    ],
                  ),
            OutlinedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              LoginComponent(message: "Goodbye!"))));
                },
                child: Text("Logout")),
          ],
        ),
      )),
    );
  }
}
