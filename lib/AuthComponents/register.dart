import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:potential_potato/AdminComponents/create_employees.dart';
import 'package:potential_potato/AuthComponents/login.dart';
import '../authComponents/image.dart';
import 'auth.dart';
import 'validate.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({super.key});

  @override
  State<RegisterComponent> createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameRegisterTextController = TextEditingController();
  final _nameRegisterFocusNode = FocusNode();
  final _emailRegisterTextController = TextEditingController();
  final _emailRegisterFocusNode = FocusNode();

  final _passwordRegisterTextController1 = TextEditingController();
  final _passwordRegisterFocusNode1 = FocusNode();
  final _passwordRegisterTextController2 = TextEditingController();
  final _passwordRegisterFocusNode2 = FocusNode();
  String _avatarPhoto = 'upload photo';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _nameRegisterFocusNode.unfocus();
          _emailRegisterFocusNode.unfocus();
          _passwordRegisterFocusNode1.unfocus();
          _passwordRegisterFocusNode2.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarUploads(
                    onSelect: (value) {
                      setState(() {
                        _avatarPhoto = value!;
                      });
                    },
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _nameRegisterTextController,
                    focusNode: _nameRegisterFocusNode,
                    validator: (value) => Validator.validateName(
                      name: value,
                    ),
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _emailRegisterTextController,
                    focusNode: _emailRegisterFocusNode,
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    decoration: InputDecoration(labelText: "Email Address"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    controller: _passwordRegisterTextController1,
                    focusNode: _passwordRegisterFocusNode1,
                    validator: (value) => Validator.validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    controller: _passwordRegisterTextController2,
                    focusNode: _passwordRegisterFocusNode2,
                    validator: (value) => Validator.validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(labelText: "Confirm Password"),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginComponent(
                                  message: "",
                                )));
                      },
                      child: Text("Back")),
                  _isProcessing
                      ? CircularProgressIndicator()
                      : OutlinedButton(
                          onPressed: () async {
                            _nameRegisterFocusNode.unfocus();
                            _emailRegisterFocusNode.unfocus();
                            _passwordRegisterFocusNode1.unfocus();
                            _passwordRegisterFocusNode2.unfocus();
                            if (_registerFormKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });
                              User? user =
                                  await FireAuth.registerUsingEmailPassword(
                                image: _avatarPhoto,
                                name: _nameRegisterTextController.text,
                                email: _emailRegisterTextController.text,
                                password: _passwordRegisterTextController2.text,
                              ).whenComplete(() => _isProcessing = false);
                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateEmployeeComponent(
                                              user: user,
                                            )));
                              }
                            }
                          },
                          child: Text("Register"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
