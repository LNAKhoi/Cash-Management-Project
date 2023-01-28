// ignore_for_file: prefer_const_constructors

import 'package:cash_management_project/API/functions.dart';
import 'package:cash_management_project/authentication/Auth.dart';
import 'package:cash_management_project/screens/home/home_screen.dart';
import 'package:cash_management_project/screens/login/login_screen.dart';
import 'package:cash_management_project/templates/custom_color.dart';
import 'package:cash_management_project/templates/screen_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  double screenWidth = 1;
  double screenHeight = 1;
  TextEditingController typeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isPassword = false;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                        CustomColor.navyBlue, 16.0, FontWeight.w600))
              ],
            ),
          ),
        ),
      ),
      body: Center(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight - 100,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildForm(context),
          ],
        ),
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

  Widget buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Transaction Details",
            style: TextStyle(
                color: CustomColor.navyBlue,
                fontFamily: ".SF Pro Text",
                fontSize: 26,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 10),
        buildInputField(typeController, "Type", screenWidth),
        buildInputField(descriptionController, "Description", screenWidth),
        buildInputField(amountController, "Amount", screenWidth),
        buildInputField(currencyController, "Currency", screenWidth),
        buildDate(context),
        SizedBox(height: 20),
        buildAddButton(),
      ],
    );
  }

  Widget buildInputField(
      TextEditingController controller, String title, double containerWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: containerWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColor.neutral70)),
          child: TextField(
            obscureText: title == "Password" ? true : false,
            controller: controller,
            decoration: InputDecoration(
              hintText: title,
              contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 12),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 8)
      ],
    );
  }

  Widget buildDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColor.neutral70)),
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
              hintText: "Date",
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
                                          dateController.text =
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

  Widget buildAddButton() {
    return GestureDetector(
      onTap: () async {
        Functions().createTransactionDescription(context,
            type: typeController.text,
            description: descriptionController.text,
            currency: currencyController.text,
            date: dateController.text,
            amount: parseTextToDouble(amountController.text));
      },
      child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: CustomColor.navyBlue,
              borderRadius: BorderRadius.circular(8)),
          child: Text("Add transaction details",
              style: customCupertinoTextStyle(
                  CustomColor.white, 14, FontWeight.w600))),
    );
  }

  double parseTextToDouble(String valueText) {
    double value = 0.0;
    try {
      value = double.parse(valueText);
    } catch (e) {}
    return value;
  }

  String formatDateTime(DateTime dateTime) {
    return dateTime.toString().split(" ").first;
  }
}
