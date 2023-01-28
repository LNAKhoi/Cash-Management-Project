import 'dart:html';

import 'package:cash_management_project/API/functions.dart';
import 'package:cash_management_project/authentication/Auth.dart';
import 'package:cash_management_project/models/transaction.dart';
import 'package:cash_management_project/screens/home/add_transaction.dart';
import 'package:cash_management_project/templates/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../templates/custom_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var screenWidth = 0.0;
  var screenHeight = 0.0;
  List<Transactions> transactions = [];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(48), child: buildAppBar()),
      body: StreamBuilder<List<Transactions>>(
          stream: Functions().readTransactions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              transactions = snapshot.data!;
            }
            return buildBody();
          }),
    );
  }

  Widget buildBody() {
    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.all(16),
      // color: Colors.amber,
      child: SingleChildScrollView(
          child: Column(
        children: [
          buildInformation(),
          SizedBox(height: 16),
          buildTransactionNotes(),
          SizedBox(height: 40),
          TextButton(
            onPressed: () => Auth().signOut(),
            child: Text("Sign out"),
          )
        ],
      )),
    );
  }

  Widget buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth,
          //height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: CustomColor.blue100.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                    DateTime.now().month.toString() +
                        "/" +
                        DateTime.now().year.toString(),
                    style: GoogleFonts.inter(
                        color: CustomColor.navyBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Spending limit:",
                            style: GoogleFonts.inter(
                                color: CustomColor.blue100,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 16),
                        Text("Gain:",
                            style: GoogleFonts.inter(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 16),
                        Text("Consume:",
                            style: GoogleFonts.inter(
                                color: CustomColor.neutral100,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 16),
                        Text("Remain:",
                            style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1400\$ ",
                            style: GoogleFonts.inter(
                                color: CustomColor.blue100,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 16),
                        Text("400\$",
                            style: GoogleFonts.inter(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 16),
                        Text("250\$",
                            style: GoogleFonts.inter(
                                color: CustomColor.neutral100,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 16),
                        Text("150\$",
                            style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildTransactionNotes() {
    return Container(
      width: screenWidth,
      height: screenHeight / 2,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CustomColor.neutral100.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Transaction History",
            style: GoogleFonts.inter(
                color: CustomColor.neutral100,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: ((context, index) {
                  return buildTransactionDetails(
                      transactions[index].type,
                      transactions[index].description,
                      transactions[index].amount.toString() +
                          transactions[index].currency);
                })),
          ),
          SizedBox(height: 16),
          buildAddTransaction()
        ],
      ),
    );
  }

  Widget buildAddTransaction() {
    return GestureDetector(
      onTap: () {
        ScreenNavigator.navigateTo(context, AddTransactionScreen());
      },
      child: Container(
          padding: EdgeInsets.all(8),
          width: screenWidth,
          decoration: BoxDecoration(
              color: CustomColor.navyBlue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CustomColor.neutral40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Add transaction details",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 4),
              Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 16,
              )
            ],
          )),
    );
  }

  Widget buildTransactionDetails(
      String title, String description, String amount) {
    var titleColor = Colors.black;
    switch (title) {
      case "Loss":
        titleColor = Colors.red;

        break;
      case "Gain":
        titleColor = Colors.green;

        break;
      default:
        titleColor = Colors.green;
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: CustomColor.neutral40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              width: screenWidth / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                        color: titleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                        color: CustomColor.neutral70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth / 2 * 0.5,
              child: Text(
                amount,
                style: GoogleFonts.inter(
                    color: titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Build custom appbar
  Widget buildAppBar() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Text("Home Page",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: CustomColor.navyBlue,
              fontFamily: ".SF Pro Text",
              fontSize: 18,
              fontWeight: FontWeight.w600)),
    );
  }
}
