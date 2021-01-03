import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './services/auth.dart';
import './models/user.dart';

import './screens/wrapper.dart';
import './screens/pending_tests/pending_tests.dart';
import './screens/approved_tests/approved_tests.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'Final Year Project',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Colors.blue.shade50,
          ),
          home: Wrapper(),
          //home: MyHomePage(title: 'Final Year Project'),
          routes: {
            '/pending-tests': (ctx) => PendingTests(),
            '/approved-tests': (ctx) => ApprovedTests(),
          }),
    );
  }
}
