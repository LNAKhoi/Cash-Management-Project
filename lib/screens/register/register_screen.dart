// ignore_for_file: prefer_const_constructors

import 'package:cash_management_project/screens/login/login_screen.dart';
import 'package:cash_management_project/templates/custom_color.dart';
import 'package:cash_management_project/templates/screen_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double screenWidth = 1;
  double screenHeight = 1;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  bool isPassword = false;
  DateTime date = DateTime.now();

  
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.white,
        elevation: 0,
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: CustomColor.navyBlue,
                ),
                Text("Back",
                    style: customCupertinoTextStyle(
                        CustomColor.navyBlue, 14.0, FontWeight.w400))
              ],
            ),
          ),
        ),
      ),
      backgroundColor: CustomColor.white,
      body: Center(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight - 100,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          buildRegisterForm(context),
          SizedBox(height: 16),
          buildAlternativeLogins(context)
        ],
      ),
    );
  }

  TextStyle customCupertinoTextStyle(
      Color color, double textSize, FontWeight weight) {
    return TextStyle(
        color: color,
        fontFamily: ".SF Pro Text",
        fontSize: textSize,
        fontWeight: weight);
  }

  Widget buildRegisterForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Join us now",
            style: TextStyle(
                color: CustomColor.navyBlue,
                fontFamily: ".SF Pro Text",
                fontSize: 26,
                fontWeight: FontWeight.w600)),
        Row(
          children: [
            Text("or",
                style: customCupertinoTextStyle(
                    CustomColor.neutral70, 12, FontWeight.w400)),
            TextButton(
              onPressed: () {
               Navigator.pop(context);
              },
              child: Text(
                "Sign in",
                style: customCupertinoTextStyle(
                    CustomColor.navyBlue, 12, FontWeight.w600),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        buildNameInput(),
        buildInputField(emailController, "Email", screenWidth),
        buildInputField(passwordController, "Password", screenWidth),
        buildBirthDay(context),
        SizedBox(height: 20),
        buildJoinNowButton(),
        SizedBox(height: 16),
        buildTermsAndCondition()
      ],
    );
  }

  Widget buildNameInput() {
    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildInputField(firstNameController, "First name", screenWidth/2-24),
          SizedBox(width: 16),
          buildInputField(lastNameController, "Last name", screenWidth/2-24),
        ],
      ),
    );
  }

  Widget buildInputField(
      TextEditingController controller, String title, double containerWidth) {
    if (title == "Password") {
      isPassword = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: customCupertinoTextStyle(
                CustomColor.neutral60, 12, FontWeight.w400)),
        SizedBox(height: 4),
        Container(
          height: 40,
          width: containerWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColor.neutral70)),
          child: TextField(
            obscureText: isPassword,
            // textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 12),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 8)
      ],
    );
  }

  Widget buildBirthDay(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Day of birth",
            style: customCupertinoTextStyle(
                CustomColor.neutral60, 12, FontWeight.w400)),
        SizedBox(height: 4),
        Container(
          height: 40,
          width: screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColor.neutral70)),
          child: TextField(
            controller: birthdayController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 12),
              border: InputBorder.none,
            ),
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  context: context,
                  builder: (context) => SizedBox(
                        height: screenHeight / 3,
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                  CupertinoButton(
                                      child: Text("Save"),
                                      onPressed: () {
                                        setState(() {
                                          birthdayController.text =
                                              formatDateTime(date);
                                          Navigator.of(context).pop();
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 200,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() => date = newDate);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
            },
          ),
        )
      ],
    );
  }

  Widget buildTermsAndCondition() {
    return Center(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "By clicking Join, you agree to our ",
            style: customCupertinoTextStyle(
                CustomColor.neutral70, 12, FontWeight.w400)),
        TextSpan(
          text: 'Terms and Conditions',
          style: customCupertinoTextStyle(
              CustomColor.blue100, 12, FontWeight.w600),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
      ])),
    );
  }

  Widget buildJoinNowButton() {
    return Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: CustomColor.navyBlue,
            borderRadius: BorderRadius.circular(8)),
        child: Text("Join now",
            style: customCupertinoTextStyle(
                CustomColor.white, 14, FontWeight.w600)));
  }

  Widget buildAlternativeLogins(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildOr(context),
        SizedBox(height: 20),
        buildSocialSignUp(
            "lib/assets/images/google_icon.png", "Sign up with Google"),
        SizedBox(height: 16),
        buildSocialSignUp(
            "lib/assets/images/facebook_icon.png", "Sign up with Facebook"),
      ],
    );
  }

  Widget buildSocialSignUp(String socialImagePath, String socialName) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: 250,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: CustomColor.neutral40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(socialImagePath, height: 24, width: 24),
            SizedBox(width: 8),
            Text(socialName,
                style: TextStyle(
                    color: CustomColor.neutral100,
                    fontFamily: ".SF Pro Text",
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget buildVerticalDivider() {
    return Container(
      width: screenWidth / 2 - 50,
      height: 0.5,
      color: CustomColor.neutral40,
    );
  }

  Widget buildOr(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        buildVerticalDivider(),
        Text(
          "Or",
          style: TextStyle(
              color: CustomColor.neutral40,
              fontFamily: ".SF Pro Text",
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        buildVerticalDivider()
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    return dateTime.toString().split(" ").first;
  }

}
