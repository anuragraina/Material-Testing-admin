import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Oops, someting went wrong!', style: TextStyle(fontSize: 18, color: Colors.red)),
            Text(
              'Please check your internet connection',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
