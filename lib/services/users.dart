import 'package:cloud_functions/cloud_functions.dart';

class UserService {
  Future createUser({String name, String email, String mobile}) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createUser');
      HttpsCallableResult result = await callable({
        'name': name,
        'email': email,
        'mobile': mobile,
      });

      return result.data;
    } catch (e) {
      print('Create User Error: $e');
      return 'error';
    }
  }
}
