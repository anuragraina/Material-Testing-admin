import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../services/auth.dart';
import '../widgets/reset_link_sent_alert.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final AuthService _auth = AuthService();

  var _formKey = GlobalKey<FormState>();

  String email = '';

  static String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(emailPattern);

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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: ListView(
          children: [
            Container(
              width: 325,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListTile(
                  leading: const Icon(Icons.email),
                  title: TextFormField(
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
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.all(5),
                child: Text(
                  'Send email',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await pr.show();
                    dynamic result = await _auth.resetPassword(email);
                    print(result);
                    await pr.hide();
                    showAlertResetLinkSent(context, email);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void resetPassword(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return ResetPass();
      });
}
