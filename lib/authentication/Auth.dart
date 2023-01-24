import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage = "";
  User? getCurrentuser() {
    return _firebaseAuth.currentUser;
  }

  String getErrorMessage() {
    return errorMessage;
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: email);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: email);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.code;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
