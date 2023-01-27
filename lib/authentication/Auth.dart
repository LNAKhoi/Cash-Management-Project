import 'package:cash_management_project/templates/custom_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? getCurrentuser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: email);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.code,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: CustomColor.neutral40,
          textColor: CustomColor.neutral100,
          fontSize: 16.0);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String firstName,
      required String lastName,
      required String dob,
      required String email,
      required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: email);
      await addUserData(firstName, lastName, dob, email);
      await signOut();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.code,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: CustomColor.neutral40,
          textColor: CustomColor.neutral100,
          fontSize: 16.0);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.code,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: CustomColor.neutral40,
          textColor: CustomColor.neutral100,
          fontSize: 16.0);
    }
  }

  Future<void> addUserData(
      String firstName, String lastName, String birthDay, String email) async {
    FirebaseFirestore.instance.collection('users').add({
      'first_name': firstName,
      'last_name': lastName,
      'birthday': birthDay,
      'email': email
    });
  }
}
