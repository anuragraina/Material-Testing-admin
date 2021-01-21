import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Sign-in error"),
        content: Text("Please check your credentials!"),
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
