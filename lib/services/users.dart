import 'package:cloud_functions/cloud_functions.dart';

class UserService {
  Future createUser({String name, String email, String mobile}) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-south1').httpsCallable(
        'createUser',
      );
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

  Future getUsers() async {
    try {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-south1').httpsCallable(
        'getUsers',
      );
      HttpsCallableResult result = await callable();

      return result.data;
    } catch (e) {
      print('Get Users Error: $e');
      return 'error';
    }
  }

  Future deleteUser(String uid) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-south1').httpsCallable(
        'deleteUser',
      );
      HttpsCallableResult result = await callable(uid);

      return result.data;
    } catch (e) {
      print('Delete User Error: $e');
      return 'error';
    }
  }
}
