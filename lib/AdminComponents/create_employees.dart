import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AuthComponents/login.dart';
//import '../Models/employee_model.dart';

class CreateEmployeeComponent extends StatefulWidget {
  const CreateEmployeeComponent({super.key, required this.user});
  final User user;

  @override
  State<CreateEmployeeComponent> createState() =>
      _CreateEmployeeComponentState();
}

class _CreateEmployeeComponentState extends State<CreateEmployeeComponent> {
  late User _currentUser;

  final List<String> _employeeRole = [
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
  String selectedRole = "none";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  Future<void> addUserToEmployeesCollection(role, User user) async {
    try {
      await firestore.collection('Employees').doc(user.uid).set({
        'employeeId': user.uid,
        'name': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'role': role,
      }).whenComplete(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginComponent(
                  message: "Success! ${user.displayName}, please login.",
                )));
      });
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('EmployeeId: ${_currentUser.uid}'),
              Text(_currentUser.displayName != null
                  ? _currentUser.displayName as String
                  : ""),
              Text(_currentUser.email as String),
              Text(_currentUser.phoneNumber != null
                  ? _currentUser.phoneNumber as String
                  : ""),
              DropdownButton<String>(
                value: selectedRole,
                onChanged: (newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
                items: _employeeRole.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role), // Display role name without enum prefix
                  );
                }).toList(),
              ),
              OutlinedButton(
                  onPressed: () {
                    addUserToEmployeesCollection(selectedRole, _currentUser);
                  },
                  child: Text("Confirm"))
            ],
          ),
        ),
      ),
    );
  }
}
