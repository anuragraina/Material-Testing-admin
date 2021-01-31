import 'package:flutter/material.dart';

import 'package:progress_dialog/progress_dialog.dart';
import '../../widgets/sign_in_error_alert.dart';
import '../../services/auth.dart';
import '../../widgets/reset_password.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  bool _obscureText = true;

  String email = '';
  String password = '';

  static String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(emailPattern);

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: true,

      /// your body here
      customBody: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );

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
          title: Text('Proton Easy+ Admin'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      width: 325,
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: TextFormField(
                          // maxLength: 32,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid email';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter email',
                            errorStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 325,
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: TextFormField(
                          obscureText: _obscureText,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            errorStyle: TextStyle(fontSize: 15),
                            suffix: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: _obscureText
                                  ? Icon(
                                      Icons.visibility_off,
                                    )
                                  : Icon(Icons.visibility),
                              onPressed: _toggle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await pr.show();
                            dynamic result = await _auth.signIn(email, password);
                            print(result);
                            await pr.hide();
                            if (result == null) {
                              //Create Alertbox
                              showAlertDialog(context);
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 100),
                      child: TextButton(
                        child: Text(
                          'Forgot Password?',
                        ),
                        onPressed: () {
                          resetPassword(context);
                        },
                      ),
                    ),
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
