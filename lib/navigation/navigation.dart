import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

enum UserNavigation { home, jobs, nearby, profile }

class _NavigationState extends State<Navigation> {
  @override
  String homeRouting = 'lib/screens/home_screen/home_screen.dart';
  Map<UserNavigation, Widget> pages = {};

  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Route createRoute(page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.linearToEaseOut,
            ),
          ),
          child: child,
        );
      },
    );
  }

  Widget buildNavigation(BuildContext context) {
    return Container(
        height: 74,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Color(0xffF4F5F6)),
            ),
            color: Color(0xffFFFFFF)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // Expanded(
          //     flex: 1,
          //     child: buildItem(context,
          //         iconPath: "${AssetUrl.product}nav-home.svg",
          //         iconPathActive: "${AssetUrl.product}nav-home-active.svg",
          //         title: "Tiny",
          //         route: UserNavigation.tiny,
          //         notify: null)),
          // Expanded(
          //     flex: 1,
          //     child: buildItem(context,
          //         iconPath: "${AssetUrl.product}nav-wallet-active.svg",
          //         iconPathActive: "${AssetUrl.product}nav-wallet.svg",
          //         title: "Wallet",
          //         route: UserNavigation.wallet,
          //         notify: null)),
          // Expanded(
          //     flex: 1,
          //     child: buildItem(context,
          //         iconPath: "${AssetUrl.product}nav-bell.svg",
          //         iconPathActive: "${AssetUrl.product}nav-bell-active.svg",
          //         title: "Notification",
          //         route: UserNavigation.notification,
          //         notify: Int64(19))),
          // Expanded(
          //     flex: 1,
          //     child: buildItem(context,
          //         iconPath: "${AssetUrl.product}nav-profile.svg",
          //         iconPathActive: "${AssetUrl.product}nav-profile-active.svg",
          //         title: "Profile",
          //         route: UserNavigation.profile,
          //         notify: null)),
        ]));
  }

  Widget buildItem(BuildContext context, String iconPath, iconPathActive,
      String title, UserNavigation route, Int64 notify) {
    // var itemSelected = (this.selectedRoute == route);
    var colorActive = Colors.blue;
    // var color = itemSelected ? colorActive : Color(0xffA4A4A4);
    return Material(
      child: InkResponse(
        onTap: () {
          setState(() {
            //this.selectedRoute = route;
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 18),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: title == "Tiny" ? 28 : 24,
                    height: 24,
                    color: Colors.transparent,
                    // child: SvgPicture.asset(
                    //   // itemSelected ? iconPathActive : iconPath,
                    //   // color: color,
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  notify != null
                      ? Positioned(
                          top: -8,
                          right: -6,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffFF3B30)),
                            child: Center(
                              child: Text(
                                notify.toString(),
                                style: TextStyle(
                                  fontFamily: ".SF Pro Text",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: ".SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  //color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
