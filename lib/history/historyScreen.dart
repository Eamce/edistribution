import 'package:edistribution/auth/login/loginScreen.dart';
import 'package:edistribution/history/orderAgain.dart';
import 'package:edistribution/history/orderDetails.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');

  bool doneQuery = false;

  String reqDateString = '';

  int offset = 0;
  var _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    if (GlobalVariables.logcustomerCode.isEmpty) {
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: LoginScreen()));
    } else {
      GlobalVariables.orderHistory = [];
      check();
      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          loadOffset();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var safePadding = MediaQuery.of(context).padding.top;
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      child: Column(
        children: [
          Container(height: safePadding, color: brandingColor),
          Container(
            color: brandingColor,
            alignment: Alignment.center,
            height: appBarSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlobalVariables.orderHistory.length > 0 ? SizedBox() : Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    "History",
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(15)),
                  ),
                ),
                GlobalVariables.orderHistory.length > 0 ? Spacer() : SizedBox(),
                GlobalVariables.orderHistory.length > 0
                    ? IconButton(
                        icon: Icon(CupertinoIcons.arrow_2_circlepath,
                            color: Colors.white),
                        onPressed: () {
                          doneQuery = false;
                          reqDateString = '';
                          offset = 0;
                          GlobalVariables.orderHistory = [];
                          if (mounted) setState(() {});
                          check();
                        },
                      )
                    : SizedBox(),
                GlobalVariables.orderHistory.length > 0 ? SizedBox() : Spacer(),
              ],
            ),
          ),
          doneQuery ? SizedBox() : Spacer(),
          doneQuery
              ? Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Container(
                    width: size.width,
                    color: Colors.greenAccent[100],
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Note: Delivery date is set to maximum of ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "two(2) ",
                              style: TextStyle(
                                color: brandingColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "working days upon placing your order. Cut-off time(",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "12:00 PM",
                              style: TextStyle(
                                color: brandingColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ").",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          doneQuery
              ? Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Container(
                    height: appBarSize / 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Text(
                              "Pending",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(11)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.orangeAccent[100],
                            child: Text(
                              "On-Process",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(11)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.lightBlueAccent[100],
                            child: Text(
                              "Approved",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(11)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.greenAccent[100],
                            child: Text(
                              "Delivered",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(11)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.redAccent[100],
                            child: Text(
                              "Cancelled",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(11)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          doneQuery
              ? GlobalVariables.orderHistory.length > 0
                  ? Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return false;
                        },
                        child: Scrollbar(
                          child: ListView.builder(
                            controller: _controller,
                            padding: EdgeInsets.all(0),
                            itemCount: GlobalVariables.orderHistory.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime req = DateTime.parse(GlobalVariables
                                  .orderHistory[index]['date_req']);
                              String status = GlobalVariables
                                  .orderHistory[index]['tran_stat'];
                              final reqDate =
                                  DateTime(req.year, req.month, req.day);
                              final now = DateTime.now();
                              final today =
                                  DateTime(now.year, now.month, now.day);
                              final yesterday =
                                  DateTime(now.year, now.month, now.day - 1);
                              if (reqDate == today) {
                                reqDateString =
                                    "TODAY, ${DateFormat("hh:mma").format(req)}";
                              } else if (reqDate == yesterday) {
                                reqDateString =
                                    "YESTERDAY, ${DateFormat("hh:mma").format(req)}";
                              } else {
                                reqDateString =
                                    "${DateFormat('dd MMM yyyy').format(req).toUpperCase()}, ${DateFormat("hh:mma").format(req)}";
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Container(
                                  // color: Colors.white,
                                  color: status == 'On-Process'
                                      ? Colors.orangeAccent[100]
                                      : status == 'Approved'
                                          ? Colors.lightBlueAccent[100]
                                          : status == 'Delivered'
                                              ? Colors.greenAccent[100]
                                              : status == 'Returned'
                                                  ? Colors.redAccent[100]
                                                  : Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("$reqDateString",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: OrderDetails(
                                                          tranno: GlobalVariables
                                                                  .orderHistory[
                                                              index]['tran_no'])));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      CupertinoIcons
                                                          .list_bullet,
                                                      color: Colors.black)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Tran #: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(14)),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${GlobalVariables.orderHistory[index]['tran_no']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(14)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      status == 'Pending' ||
                                              status == 'On-Process'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Amount: ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14)),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${nF.format(double.parse(GlobalVariables.orderHistory[index]['tot_amt']))}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Amount: ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14)),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${nF.format(double.parse(GlobalVariables.orderHistory[index]['tot_del_amt']))}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, bottom: 8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Placed by: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(14)),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${GlobalVariables.orderHistory[index]['order_by']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(14)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      status == 'Delivered'
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child: OrderAgain(
                                                            tranno: GlobalVariables
                                                                        .orderHistory[
                                                                    index]
                                                                ['tran_no'])));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Container(
                                                  height: appBarSize / 2,
                                                  child: Text(
                                                    "ORDER AGAIN",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      status == 'Returned'
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Container(
                                                height: appBarSize / 2,
                                                child: Text(
                                                  "Reason: ${GlobalVariables.orderHistory[index]['reason']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : nothing()
              : loadingHistory(),
          doneQuery ? SizedBox() : Spacer(),
          Container(
            height: bottomPadding,
          ),
        ],
      ),
    );
  }

  check() async {
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      offset = 0;
      var history = await getOrderHistory(context, offset);
      if (history != null) {
        GlobalVariables.orderHistory = history;
        offset = offset + 10;
        doneQuery = true;
        if (mounted) setState(() {});
      } else {
        doneQuery = true;
        if (mounted) setState(() {});
      }
    }
  }

  loadOffset() async {
    print(offset);
    var history = await getOrderHistory(context, offset);
    if (history != null) {
      List offsetP = history;
      GlobalVariables.orderHistory.addAll(offsetP);
      offset = offset + 10;
      if (mounted) setState(() {});
    }
  }

  Widget loadingHistory() {
    return Column(
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget nothing() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.list_bullet_below_rectangle),
          Text("Empty history"),
        ],
      ),
    );
  }
}
