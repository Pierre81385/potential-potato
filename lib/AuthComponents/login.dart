import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:potential_potato/AuthComponents/register.dart';
import '../home.dart';
import 'auth.dart';
import 'validate.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key, required this.message});
  final String message;

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailLoginTextController = TextEditingController();
  final _emailLoginFocusNode = FocusNode();
  final _passwordLoginTextController1 = TextEditingController();
  final _passwordLoginFocusNode1 = FocusNode();
  bool _isProcessing = false;
  String _message = "";

  @override
  void initState() {
    _message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _emailLoginFocusNode.unfocus();
          _passwordLoginFocusNode1.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_message),
                  ),
                  TextFormField(
                    controller: _emailLoginTextController,
                    focusNode: _emailLoginFocusNode,
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    decoration: InputDecoration(labelText: "Email Address"),
                  ),
                  TextFormField(
                    controller: _passwordLoginTextController1,
                    focusNode: _passwordLoginFocusNode1,
                    validator: (value) => Validator.validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterComponent()));
                      },
                      child: Text("I'm a New User")),
                  _isProcessing
                      ? CircularProgressIndicator()
                      : OutlinedButton(
                          onPressed: () async {
                            _emailLoginFocusNode.unfocus();
                            _passwordLoginFocusNode1.unfocus();

                            if (_loginFormKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });
                              User? user =
                                  await FireAuth.signInUsingEmailPassword(
                                email: _emailLoginTextController.text,
                                password: _passwordLoginTextController1.text,
                              ).whenComplete(() => _isProcessing = false);
                              if (user != null) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => HomeComponent(
                                              user: user,
                                            )));
                              }
                            }
                          },
                          child: Text("Login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
