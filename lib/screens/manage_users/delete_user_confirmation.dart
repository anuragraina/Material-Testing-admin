import 'package:flutter/material.dart';

import '../../services/users.dart';

showAlertDeleteUser(BuildContext context, String uid) {
  final UserService _user = UserService();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Do you want to delete the user?"),
        content: Text(
            "This will permanently delete the user from the database. Proceed only if you are sure"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text(
              'DELETE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              dynamic result = await _user.deleteUser(uid);
              print(result);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
