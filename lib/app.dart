import 'package:flutter/material.dart';

import './screens/delete_user/delete_user.dart';
import './screens/update_user/update_user.dart';
import './screens/add_user/add_user.dart';
import './screens/manage_user/manage_users.dart';
import './screens/manage_sites/manage_sites.dart';
import './screens/tests_analysis/test_analysis.dart';
import './screens/home_page/main_home.dart';
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
            primarySwatch: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Colors.purple.shade50,
          ),
          home: Wrapper(),
          //home: MyHomePage(title: 'Final Year Project'),
          routes: {
            './main-home': (ctx) => MainHome(),
            './test-analysis': (ctx) => TestAnalysis(),
            './manage-users': (ctx) => ManageUsers(),
            '/pending-tests': (ctx) => PendingTests(),
            '/approved-tests': (ctx) => ApprovedTests(),
            '/add-user': (ctx) => AddUser(),
            '/update-user': (ctx) => UpdateUser(),
            '/delete-user': (ctx) => DeleteUser(),
            './manage-sites': (ctx) => ManageSites(),
          }),
    );
  }
}
