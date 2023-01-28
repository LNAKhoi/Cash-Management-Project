import 'package:cloud_firestore/cloud_firestore.dart';
class Transactions {
  String type;
  String description = "";
  String currency = "";
  double amount = 0.0;
  String date = "";

  Transactions({
    required this.type,
    required this.description,
    required this.currency,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'description': description,
        'currency': currency,
        'amount': amount,
        'date': date,
      };

  static Transactions fromJson(Map<String, dynamic> json) => Transactions(
      type: json['type'],
      description: json['description'],
      currency: json['currency'],
      amount: json['amount'],
      date: json['date']);
}
