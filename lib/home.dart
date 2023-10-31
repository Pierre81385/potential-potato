import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:potential_potato/AuthComponents/login.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key, required this.user});
  final User user;

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  String userStatus = "User not authenticated.";
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Ok, You've now logged in via Firebase Auth!"),
            Text(_currentUser.toString()),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginComponent(
                            message: "",
                          )));
                },
                child: Text("Next")),
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
