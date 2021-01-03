import 'package:flutter/material.dart';
import 'package:material_testing_admin/screens/home_page/main_home.dart';
import 'package:provider/provider.dart';

import './sign_in/sign_in.dart';
import './home_page/main_home.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    if (user == null) {
      return SignIn();
    } else {
      return MainHome();
    }
  }
}
