import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../services/users.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final UserService _user = UserService();

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30),
            width: 325,
            child: TextField(
              onChanged: (value) {
                setState(() => name = value);
              },
              decoration: InputDecoration(
                hintText: 'Enter name of employee',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            width: 325,
            child: TextField(
              onChanged: (value) {
                setState(() => email = value);
              },
              decoration: InputDecoration(
                hintText: 'Enter email address',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            width: 325,
            child: TextField(
              onChanged: (value) {
                setState(() => mobile = value);
              },
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
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
                await pr.show();
                dynamic result = await _user.createUser(
                  name: name,
                  email: email,
                  mobile: mobile,
                );
                print(result);
                await pr.hide();
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

// () async {
//

//
//           },
