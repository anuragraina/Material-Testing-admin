//Delete create user function, since it already exists in users.dart

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create a user obj based on Firebase user
  CustomUser _createUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_createUser);
  }

  //Reset Password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

//Sign in the user
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user;
      return _createUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e);
      }

      return null;
    }
  }

  //SignOut the user
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String currentUser() {
    final User user = _auth.currentUser;
    return user.uid;
  }
}
