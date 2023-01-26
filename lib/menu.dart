import 'dart:async';
import 'package:edistribution/account/accountScreen.dart';
import 'package:edistribution/auth/login/loginScreen.dart';
import 'package:edistribution/cart/cartScreen.dart';
import 'package:edistribution/history/historyScreen.dart';
import 'package:edistribution/home/homeScreen.dart';
import 'package:edistribution/products/searchProductsBarcode.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Widget> _screenList = [
    Home(),
    CartScreen(),
    Container(),
    HistoryScreen(),
    AccountScreen(),
  ];

  Timer? cartTimer;

  @override
  void initState() {
    super.initState();

    cartTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    if (GlobalVariables.logcustomerCode.isNotEmpty) {
      sessionTimer.initializeTimer(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (cartTimer != null) cartTimer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var smallestDimension = MediaQuery.of(context).size.shortestSide;
    GlobalVariables.axisCount = smallestDimension < 600 ? 2 : 3;
    GlobalVariables.menuContext = context;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          extendBody: true,
          body: _screenList[GlobalVariables.menuCurrentIndex],
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: Icon(CupertinoIcons.barcode_viewfinder, size: 30),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: SearchProductsBarcode()));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.red,
            notchMargin: 4,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BottomNavigationBar(
              unselectedIconTheme: IconThemeData(color: Colors.blueGrey[900]),
              selectedIconTheme: IconThemeData(color: brandingColor),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              currentIndex: GlobalVariables.menuCurrentIndex,
              onTap: GlobalVariables.logcustomerCode.isNotEmpty
                  ? onTapped
                  : (_) {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginScreen()));
                    },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(CupertinoIcons.cart),
                        GlobalVariables.cartItemCount > 0
                            ? Positioned(
                                right: -8,
                                top: -8,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: brandingColor,
                                      shape: BoxShape.circle),
                                  height: 18.0,
                                  width: 18.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: FittedBox(
                                      child: Text(
                                        "${GlobalVariables.cartItemCount}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.app, color: Colors.white),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.bag), label: 'History'),
                BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(CupertinoIcons.person),
                        GlobalVariables.chatCount > 0
                            ? Positioned(
                                right: -8,
                                top: -8,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: brandingColor,
                                      shape: BoxShape.circle),
                                  height: 18.0,
                                  width: 18.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: FittedBox(
                                      child: Text(
                                        "${GlobalVariables.chatCount}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    label: 'Account'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapped(int index) {
    if (index != 2) {
      GlobalVariables.menuCurrentIndex = index;
      setState(() {});
    }
  }
}
