import 'package:cash_management_project/authentication/Auth.dart';
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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(48), child: buildAppBar()),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.all(16),
      // color: Colors.amber,
      child: SingleChildScrollView(child: Column(
        children: [
          buildInformation(),
          SizedBox(height: 16), 
          buildTransactionNotes(),
          SizedBox(height: 40),
          TextButton(onPressed: () => Auth().signOut(),child: Text("Sign out"),)
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
          height: 120,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spending limit:",
                        style: GoogleFonts.inter(
                            color: CustomColor.blue100,
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
                padding: EdgeInsets.only(left: 8, top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("400\$",
                        style: GoogleFonts.inter(
                            color: CustomColor.blue100,
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
        )
      ],
    );
  }

  Widget buildTransactionNotes() {
    return Container(
      width: screenWidth,
      height:screenHeight/2,
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
