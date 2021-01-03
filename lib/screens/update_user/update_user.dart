import 'package:flutter/material.dart';

class UpdateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This functionality will be added soon!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
