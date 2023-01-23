// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:cash_management_project/templates/custom_color.dart';
import 'package:cash_management_project/templates/screen_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // Animation Controller
  late AnimationController animationController;
  late Animation<double> animation;

  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  double screenWidth = 1;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.repeat();
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF3F3F3),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 32),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLogo(),
            SizedBox(height: 20),
            buildLoginInput(context),
            SizedBox(height: 32),
            buildButtonLogin(context),
          ],
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Column(children: [
      animation != null
          ? RotationTransition(
              turns: animation,
              child: Image.asset("lib/assets/images/splash_screen_logo.png",
                  width: 100, height: 100),
            )
          : Image.asset("lib/assets/images/splash_screen_logo.png",
              width: 100, height: 100),
      SizedBox(height: 20),
      Text("Cash Management",
          style: TextStyle(
              color: Color(0xff036BA6),
              fontFamily: ".SF Pro Text",
              fontSize: 26,
              fontWeight: FontWeight.w600))
    ]);
  }

  Widget buildLoginInput(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColor.backgroundInputText,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: inputUsername,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: 'Username'),
            onChanged: (value) {
              // Do sth
            },
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: CustomColor.backgroundInputText,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            obscureText: true,
            controller: inputPassword,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: 'Password'),
            onChanged: (value) {
              // Do sth
            },
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [buildRegister(context), buildForgotPassword(context)],
        )
      ],
    );
  }

  Widget buildButtonLogin(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        key: Key("loginButton"),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xff036BA6),
        onPressed: () {
          // todo: Navigate to home screen if account is valid
        },
        child: Text("Login",
            style: TextStyle(
                color: CustomColor.white,
                fontFamily: ".SF Pro Text",
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget buildForgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {
        // todo: Navigate to home screen if account is valid
      },
      child: Text("Forgot password?",
          style: TextStyle(
              color: CustomColor.blue100,
              fontFamily: ".SF Pro Text",
              fontSize: 15,
              fontWeight: FontWeight.w400)),
    );
  }

  Widget buildRegister(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'Not a member? ',
      style: TextStyle(
          color: CustomColor.blue100,
          fontFamily: ".SF Pro Text",
          fontSize: 14,
          fontWeight: FontWeight.w400),
      children: [
        TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            text: 'Register here',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ));
  }
}
