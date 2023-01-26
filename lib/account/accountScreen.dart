import 'dart:async';

import 'package:edistribution/account/changePassword.dart';
import 'package:edistribution/account/chat/chatMessages.dart';
import 'package:edistribution/account/contactUsScreen.dart';
import 'package:edistribution/account/favoritesScreen.dart';
import 'package:edistribution/account/feedbackScreen.dart';
import 'package:edistribution/auth/login/loginScreen.dart';
import 'package:edistribution/menu.dart';
import 'package:edistribution/privacy/dataPrivacy.dart';
import 'package:edistribution/utility/cartCountTimer.dart';
import 'package:edistribution/utility/chatCountTimer.dart';
import 'package:edistribution/utility/concurrentLoginTimer.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customLogicalModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Sessiontimer sessiontimer = Sessiontimer();
  CartCountTimer cartCountTimer = CartCountTimer();
  Concurrentlogintimer concurrentlogintimer = Concurrentlogintimer();
  ChatCountTimer chatCountTimer = ChatCountTimer();

  Timer? messagesTimer;

  @override
  void initState() {
    super.initState();

    if (GlobalVariables.logcustomerCode.isEmpty) {
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: LoginScreen()));
    } else {
      print("timer");
      messagesTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (messagesTimer != null) messagesTimer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var safePadding = MediaQuery.of(context).padding.top;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(height: safePadding, color: brandingColor),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.person_alt_circle,
                            size: appBarSize + (appBarSize / 2),
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${GlobalVariables.logcustomerName}",
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              Text("${GlobalVariables.logcustomerAddress}",
                                  maxLines: 2, overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.heart,
                                color: Colors.blueGrey[900]),
                            Text(" Favourites"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: FavoritesScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    "ACCOUNT",
                    style: TextStyle(color: Colors.blueGrey[900]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.lock_circle,
                                color: Colors.blueGrey[900]),
                            Text(" Change Password"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ChangePassword()));
                      },
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.text_bubble,
                                color: Colors.blueGrey[900]),
                            Text(" Messages"),
                            GlobalVariables.chatCount > 0
                                ? Container(
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
                                              color: Colors.white,
                                              fontSize: 11),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ChatMessages()))
                            .then((value) {
                          if (mounted) setState(() {});
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    "DATA PRIVACY",
                    style: TextStyle(color: Colors.blueGrey[900]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.doc_plaintext,
                                color: Colors.blueGrey[900]),
                            Text(" Data Privacy"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: DataPrivacy(
                                  useFor: "LOG-VIEW",
                                )));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    "ABOUT",
                    style: TextStyle(color: Colors.blueGrey[900]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.app, color: Colors.blueGrey[900]),
                          Text(" App Version"),
                          Spacer(),
                          Text(GlobalVariables.appVersion),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.square_favorites,
                                color: Colors.blueGrey[900]),
                            Text(" Send Feedback"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: FeedbackScreen()));
                      },
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.phone_down_circle,
                                color: Colors.blueGrey[900]),
                            Text(" Contact Us"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ContactUsScreen()));
                      },
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.person_alt_circle,
                                color: Colors.blueGrey[900]),
                            Text(" Logout"),
                            Spacer(),
                            Icon(CupertinoIcons.square_arrow_left,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        //logout
                        customLogicalModal(
                            context,
                            Text("Are you sure you want to logout?"),
                            () => Navigator.pop(context), () {
                          // imageCache!.clear();
                          // imageCache!.clearLiveImages();
                          sessiontimer.cancelSessiontimer();
                          cartCountTimer.cancelCartCount();
                          concurrentlogintimer.cancelCheckingconcurrentlog();
                          chatCountTimer.cancelChatCount();
                          GlobalVariables.logcustomerCode = '';
                          GlobalVariables.menuCurrentIndex = 0;
                          GlobalVariables.cartItemCount = 0;
                          if (mounted) setState(() {});
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Menu(),
                            ),
                            (Route route) =>
                                false, //if you want to disable back feature set to false1
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
