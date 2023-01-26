import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  final String tranno;
  const OrderDetails({Key? key, required this.tranno}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  bool doneQuery = false;

  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');

  double totsub = 0.0;
  double totuns = 0.0;
  double totret = 0.0;

  @override
  void initState() {
    super.initState();
    GlobalVariables.orderDetails = [];
    check();
  }

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    if (GlobalVariables.logcustomerCode.isNotEmpty) {
      sessionTimer.initializeTimer(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("${widget.tranno}",
                style: TextStyle(color: Colors.blueGrey[900])),
            bottom: PreferredSize(
                child: connectionChecking == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          connectionChecingStatus != ''
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    connectionChecingStatus!,
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 10),
                                  ),
                                )
                              : SizedBox(),
                          LinearProgressIndicator(),
                        ],
                      )
                    : SizedBox(),
                preferredSize: Size.fromHeight(4.0)),
          ),
          body: SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: Column(
                children: [
                  doneQuery ? SizedBox() : Spacer(),
                  doneQuery
                      ? GlobalVariables.orderDetails.length > 0
                          ? Expanded(
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowIndicator();
                                  return false;
                                },
                                child: Scrollbar(
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount:
                                        GlobalVariables.orderDetails.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var ret = '0';
                                      var uns = '0';
                                      var del = GlobalVariables
                                          .orderDetails[index]['del_qty'];
                                      List ru = GlobalVariables
                                          .orderDetails[index]['retUns'];
                                      ru.forEach((element) {
                                        if (element['itm_stat'] == 'Returned') {
                                          ret = element['qty'];
                                        }
                                        if (element['itm_stat'] == 'Unserved') {
                                          uns = element['qty'];
                                        }
                                      });
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0, top: 3.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: size.height / 10,
                                                    width: size.height / 10,
                                                    color: Colors.white,
                                                    child: CachedNetworkImage(
                                                      imageUrl: ServerUrl
                                                              .itmImgUrl +
                                                          GlobalVariables
                                                                  .orderDetails[
                                                              index]['item_path'],
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error,
                                                              color: Colors
                                                                  .grey[200]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0,
                                                                right: 3.0),
                                                        child: Text(
                                                            GlobalVariables
                                                                        .orderDetails[
                                                                    index]
                                                                ['item_desc'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0,
                                                                right: 3.0),
                                                        child: Text(
                                                            GlobalVariables
                                                                    .orderDetails[
                                                                index]['uom'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0,
                                                                right: 3.0),
                                                        child: Text(
                                                            "${nF.format(double.parse(GlobalVariables.orderDetails[index]['amt']))}",
                                                            style: TextStyle(
                                                                color:
                                                                    brandingColor),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 3.0,
                                                                right: 3.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "Requested Qty: ${GlobalVariables.orderDetails[index]['req_qty']}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1),
                                                            Spacer(),
                                                            Text(
                                                                "${nF.format(int.parse(GlobalVariables.orderDetails[index]['req_qty']) * double.parse(GlobalVariables.orderDetails[index]['amt']))}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1),
                                                          ],
                                                        ),
                                                      ),
                                                      uns != '0'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 3.0,
                                                                      right:
                                                                          3.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      "Unserved Qty: $uns",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1),
                                                                  Spacer(),
                                                                  Text(
                                                                      "(${nF.format(int.parse(uns) * double.parse(GlobalVariables.orderDetails[index]['amt']))})",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      ret != '0'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 3.0,
                                                                      right:
                                                                          3.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      "Returned Qty: $ret",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1),
                                                                  Spacer(),
                                                                  Text(
                                                                      "(${nF.format(int.parse(ret) * double.parse(GlobalVariables.orderDetails[index]['amt']))})",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      del != '0'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 3.0,
                                                                      right:
                                                                          3.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      "Delivered Qty: ${GlobalVariables.orderDetails[index]['del_qty']}",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1),
                                                                  Spacer(),
                                                                  Text(
                                                                      "${nF.format(int.parse(GlobalVariables.orderDetails[index]['del_qty']) * double.parse(GlobalVariables.orderDetails[index]['amt']))}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
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
                      : loadingDetails(),
                  doneQuery
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 3.0, right: 3.0, top: 3.0),
                          child: Container(
                            color: Colors.white,
                            // height: appBarSize * 2,
                            width: size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: size.width / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0, top: 3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text("Sub Total:",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                            Text("Total Unserved:",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                            Text("Total Returned:",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                            Text("Total Amount:",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0, right: 3.0, top: 3.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text("${nF.format(totsub)}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1),
                                              Text("(${nF.format(totuns)})",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1),
                                              Text("(${nF.format(totret)})",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1),
                                              Text(
                                                  "${nF.format(totsub - totuns - totret)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  doneQuery ? SizedBox() : Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  check() async {
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      var detail = await getOrderHistoryDetail(context, widget.tranno);
      if (detail != null) {
        GlobalVariables.orderDetails = detail;
        GlobalVariables.orderDetails.forEach((element) {
          totsub = totsub +
              (int.parse(element['req_qty']) * double.parse(element['amt']));
          List ru = element['retUns'];
          ru.forEach((element2) {
            if (element2['itm_stat'] == 'Returned') {
              totret = totret +
                  (int.parse(element2['qty']) * double.parse(element['amt']));
            }
            if (element2['itm_stat'] == 'Unserved') {
              totuns = totuns +
                  (int.parse(element2['qty']) * double.parse(element['amt']));
            }
          });
        });

        doneQuery = true;
        if (mounted) setState(() {});
      } else {
        doneQuery = true;
        if (mounted) setState(() {});
      }
    }
  }

  Widget nothing() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.list_bullet_below_rectangle),
          Text("Empty"),
        ],
      ),
    );
  }

  Widget loadingDetails() {
    return Column(
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
