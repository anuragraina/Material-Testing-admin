import 'package:flutter/material.dart';
import '../services/database.dart';

showAlertDeleteSite(BuildContext context, String id) {
  final DatabaseService _db = DatabaseService();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Do you want to delete the site?"),
        content: Text(
            "This will delete the site permanently from the database. Proceed only if you are sure"),
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
            onPressed: () => {
              _db.deleteSite(id),
              Navigator.of(context).pop(),
            },
          ),
        ],
      );
    },
  );
}
