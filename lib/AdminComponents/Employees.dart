import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AuthComponents/login.dart';
import '../Models/employee_model.dart';

class EmployeeComponent extends StatefulWidget {
  const EmployeeComponent({super.key, required this.user});
  final User user;

  @override
  State<EmployeeComponent> createState() => _EmployeeComponentState();
}

class _EmployeeComponentState extends State<EmployeeComponent> {
  late User _currentUser;

  List<String> _employeeRole = [
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
  String selectedRole = EmployeeRole[15]; // Initially selected role

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  Future<void> addUserToEmployeesCollection(role, User user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    print("addUserToEmployeesCollection called");
    try {
      await firestore.collection('Employees').add({
        'employeeId': user.uid,
        'name': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'role': role,
      }).whenComplete(() {
        print("employee added!");
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
                    print("confirm button pressed");
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
