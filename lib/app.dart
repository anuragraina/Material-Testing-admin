import 'package:flutter/material.dart';

import './screens/manage_users/manage_users.dart';
import './screens/manage_sites/manage_sites.dart';
import './screens/tests_analysis/test_analysis.dart';
import './screens/home_page/main_home.dart';
import 'package:provider/provider.dart';

import './services/auth.dart';
import './models/user.dart';

import './screens/wrapper.dart';
import './screens/pending_tests/pending_tests.dart';
import './screens/pending_tests/users.dart';
import './screens/approved_tests/approved_tests.dart';
import './screens/approved_tests/users.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'Final Year Project',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Colors.purple.shade50,
          ),
          home: Wrapper(),
          //home: MyHomePage(title: 'Final Year Project'),
          routes: {
            '/main-home': (ctx) => MainHome(),
            '/test-analysis': (ctx) => TestAnalysis(),
            '/manage-users': (ctx) => ManageUsers(),
            '/pending-tests/tests': (ctx) => PendingTests(),
            '/pending-tests/users': (ctx) => PendingTestUserList(),
            '/approved-tests/tests': (ctx) => ApprovedTests(),
            '/approved-tests/users': (ctx) => ApprovedTestUserList(),
            '/manage-sites': (ctx) => ManageSites(),
          }),
    );
  }
}
