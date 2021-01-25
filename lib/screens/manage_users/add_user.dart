import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../services/users.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final UserService _user = UserService();

  var _formKey = GlobalKey<FormState>();

  static String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(emailPattern);

  String name = '';
  String email = '';
  String mobile = '';

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
    return Padding(
      padding: EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 325,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() => name = value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter name of employee',
                  errorStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 325,
              child: TextFormField(
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
                  hintText: 'Enter email address',
                  errorStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 325,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter mobile number';
                  } else if (value.length != 10) {
                    return 'Please enter valid mobile number';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() => mobile = value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter mobile number',
                  errorStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(
                  'Create User',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await pr.show();
                    dynamic result = await _user.createUser(
                      name: name,
                      email: email,
                      mobile: mobile,
                    );
                    print(result);
                    await pr.hide();
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// () async {
//

//
//           },
