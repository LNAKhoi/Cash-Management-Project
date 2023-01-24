import 'package:cash_management_project/authentication/Auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text("Sign out"),
        onPressed: () {
          Auth().signOut();
        },
      ),
    );
  }
}
