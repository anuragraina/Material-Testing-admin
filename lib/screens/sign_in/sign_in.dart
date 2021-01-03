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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sign In'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Form(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      width: 325,
                      child: TextFormField(
                        // autofocus: true,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter email',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 325,
                      child: TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        dynamic result = await _auth.signIn(email, password);
                        print(result.uid);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
