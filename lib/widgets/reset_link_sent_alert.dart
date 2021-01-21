import 'package:flutter/material.dart';

showAlertResetLinkSent(BuildContext context, String email) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Successful"),
        content: Text("Password reset link has been sent to $email"),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
