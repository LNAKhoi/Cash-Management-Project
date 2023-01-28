/*
  This class defines CRUD events to Firebase database
*/

import 'package:cash_management_project/models/transaction.dart';
import 'package:cash_management_project/templates/screen_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../templates/custom_color.dart';

class Functions {
  // create new transaction details

  Future createTransactionDescription(BuildContext context,
      {required String type,
      required String description,
      required String currency,
      required String date,
      required double amount}) async {
    try {
      FirebaseFirestore.instance.collection("transaction_details").add({
        "type": type,
        "description": description,
        "date": date,
        "amount": amount,
        "currency": currency
      }).then((value) => Navigator.pop(context));
    } on FirebaseFirestore catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: CustomColor.neutral40,
          textColor: CustomColor.neutral100,
          fontSize: 16.0);
    }
  }

  Stream<List<Transactions>> readTransactions() => FirebaseFirestore.instance
      .collection('transaction_details')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map<Transactions>((doc) => Transactions.fromJson(doc.data()))
          .toList());
}
