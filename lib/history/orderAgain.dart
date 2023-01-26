import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderAgain extends StatefulWidget {
  final String tranno;
  const OrderAgain({Key? key, required this.tranno}) : super(key: key);

  @override
  _OrderAgainState createState() => _OrderAgainState();
}

class _OrderAgainState extends State<OrderAgain> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  bool doneQuery = false;

  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');

  int outOfStockItem = 0;

  @override
  void initState() {
    super.initState();
    GlobalVariables.orderAgainItems = [];
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("${widget.tranno}",
                style: TextStyle(color: Colors.blueGrey[900])),
            actions: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.cart_badge_plus,
                  color: brandingColor,
                ),
                onPressed: () {
                  addToCart();
                },
              ),
            ],
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
                      ? GlobalVariables.orderAgainItems.length > 0
                          ? Expanded(
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowIndicator();
                                  return false;
                                },
                                child: Scrollbar(
                                  child: ListView.builder(
                                    itemCount:
                                        GlobalVariables.orderAgainItems.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool lessPrice = double.parse(
                                                  GlobalVariables
                                                          .orderAgainItems[
                                                      index]['amt']) >
                                              double.parse(GlobalVariables
                                                      .orderAgainItems[index]
                                                  ['list_price_wtax'])
                                          ? true
                                          : false;
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, right: 3.0, top: 3.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: GlobalVariables
                                                                .orderAgainItems[
                                                            index]['chk'] ==
                                                        '1'
                                                    ? true
                                                    : false,
                                                onChanged: (val) {
                                                  val == true
                                                      ? GlobalVariables
                                                              .orderAgainItems[
                                                          index]['chk'] = "1"
                                                      : GlobalVariables
                                                              .orderAgainItems[
                                                          index]['chk'] = "0";

                                                  if (mounted) setState(() {});
                                                },
                                              ),
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
                                                                  .orderAgainItems[
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
                                                                        .orderAgainItems[
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
                                                                    .orderAgainItems[
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
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${nF.format(double.parse(GlobalVariables.orderAgainItems[index]['list_price_wtax']))}",
                                                                style: TextStyle(
                                                                    color:
                                                                        brandingColor),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1),
                                                            Text("  "),
                                                            lessPrice
                                                                ? Text(
                                                                    " ${nF.format(double.parse(GlobalVariables.orderAgainItems[index]['amt']))} ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1)
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height:
                                                                  size.height /
                                                                      35,
                                                              width:
                                                                  size.height /
                                                                      35,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      brandingColor,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: Icon(
                                                                  CupertinoIcons
                                                                      .minus,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onTap: () {
                                                              if (int.parse(GlobalVariables
                                                                              .orderAgainItems[
                                                                          index]
                                                                      [
                                                                      'req_qty']) >
                                                                  1) {
                                                                GlobalVariables
                                                                            .orderAgainItems[
                                                                        index][
                                                                    'req_qty'] = (int.parse(GlobalVariables.orderAgainItems[index]
                                                                            [
                                                                            'req_qty']) -
                                                                        1)
                                                                    .toString();
                                                                if (mounted)
                                                                  setState(
                                                                      () {});
                                                              }
                                                            },
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          15.0,
                                                                      left:
                                                                          15.0),
                                                              child: Text(
                                                                "${GlobalVariables.orderAgainItems[index]['req_qty']}",
                                                              )),
                                                          InkWell(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height:
                                                                  size.height /
                                                                      35,
                                                              width:
                                                                  size.height /
                                                                      35,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      brandingColor,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: Icon(
                                                                  CupertinoIcons
                                                                      .plus,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onTap: () {
                                                              if (int.parse(GlobalVariables
                                                                              .orderAgainItems[
                                                                          index]
                                                                      [
                                                                      'req_qty']) <
                                                                  100) {
                                                                GlobalVariables
                                                                            .orderAgainItems[
                                                                        index][
                                                                    'req_qty'] = (int.parse(GlobalVariables.orderAgainItems[index]
                                                                            [
                                                                            'req_qty']) +
                                                                        1)
                                                                    .toString();
                                                                if (mounted)
                                                                  setState(
                                                                      () {});
                                                              }
                                                            },
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                              "${nF.format(int.parse(GlobalVariables.orderAgainItems[index]['req_qty']) * double.parse(GlobalVariables.orderAgainItems[index]['list_price_wtax']))}",
                                                              style: TextStyle(
                                                                  color:
                                                                      brandingColor)),
                                                        ],
                                                      ),
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
      var detail =
          await getOrderHistoryDetailOrderAgain(context, widget.tranno);
      if (detail != null) {
        GlobalVariables.orderAgainItems = detail;
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

  addToCart() async {
    showDialog<String>(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );

    connectionChecking = true;
    connectionChecingStatus = 'Adding to cart';
    if (mounted) setState(() {});

    for (int i = 0; i < GlobalVariables.orderAgainItems.length; i++) {
      if (GlobalVariables.orderAgainItems[i]['chk'] == '1') {
        if (GlobalVariables.orderAgainItems[i]['status'] == '1') {
          await insertOnCart(
              context,
              GlobalVariables.logcustomerCode,
              GlobalVariables.orderAgainItems[i]['itm_code'],
              GlobalVariables.orderAgainItems[i]['uom'],
              int.parse(GlobalVariables.orderAgainItems[i]['req_qty']));
        } else {
          outOfStockItem = outOfStockItem + 1;
        }
      }
      if (i == GlobalVariables.orderAgainItems.length - 1) {
        connectionChecking = false;
        connectionChecingStatus = '';
        Navigator.pop(context);
        if (mounted) setState(() {});

        customModal(
            context,
            Icon(CupertinoIcons.info_circle, size: 50, color: Colors.blue),
            Text(
                "Item(s) that are not tagged as OUT OF STOCK are successfully added to your cart. ${outOfStockItem > 0 ? "Out of stock: $outOfStockItem item(s)" : ""}",
                textAlign: TextAlign.center),
            false,
            Icon(
              CupertinoIcons.checkmark,
              size: 25,
              color: Colors.green,
            ),
            'Okay', () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    }
  }
}
