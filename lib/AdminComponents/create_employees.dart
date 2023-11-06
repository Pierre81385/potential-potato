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

  String selectedRole = "SELECT";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _allRoles;

  @override
  void initState() {
    _currentUser = widget.user;
    _allRoles = FirebaseFirestore.instance
        .collection('roles')
        .snapshots(); //get all roles
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
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('roles').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Center(
                        child: const CircularProgressIndicator(),
                      );
                    return DropdownButton(
                        isExpanded: true,
                        value: selectedRole,
                        items: snapshot.data?.docs.map((doc) {
                          var role = doc.data() as Map<String, dynamic>;
                          var roleId = doc.id;
                          return DropdownMenuItem<String>(
                            value: roleId,
                            child: ListTile(
                              title: Text('${role['name']}'),
                              trailing: Text('Lvl: ${role['lvl']}'),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        });
                  }),
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
