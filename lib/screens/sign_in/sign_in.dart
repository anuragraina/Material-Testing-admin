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
  final AuthService _auth = AuthService();

  bool _obscureText = true;

  String email = '';
  String password = '';

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
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
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
              child: Center(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      width: 325,
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: TextFormField(
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter email',
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
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter password',
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
                          await pr.show();
                          dynamic result = await _auth.signIn(email, password);
                          print(result);
                          await pr.hide();
                          if (result == null) {
                            //Create Alertbox
                            showAlertDialog(context);
                          }
                        },
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Forgot Password?',
                      ),
                      onPressed: () {
                        resetPassword(context);
                      },
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
