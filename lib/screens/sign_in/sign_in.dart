import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Sign In'),
                onPressed: () async {
                  dynamic result = await _auth.signIn(email, password);
                  print(result.uid);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
