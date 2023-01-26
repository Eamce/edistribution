import 'package:edistribution/services/api.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customLogicalModal.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:edistribution/widget/customPaymentMethodModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  final noOfItems;

  const CheckOut({Key? key, required this.noOfItems}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  int id = 1;
  double totalAmount = GlobalVariables.cartTotalAmt;
  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');

  @override
  void initState() {
    GlobalVariables.selectedPaymentMethod = 'Cash on Delivery';
    super.initState();
  }

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    sessionTimer.initializeTimer(context);
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
            title:
                Text("Checkout", style: TextStyle(color: Colors.blueGrey[900])),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.placemark),
                                  Text(
                                    "  Delivery Address",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.placemark_fill,
                                      color: Colors.transparent),
                                  Flexible(
                                    child: Text(
                                      "${GlobalVariables.logcustomerAddress}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 3.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.square_list),
                                  Text(
                                    "  Details",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.placemark_fill,
                                      color: Colors.transparent),
                                  Flexible(
                                    child: Text(
                                      "Order Date: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.placemark_fill,
                                      color: Colors.transparent),
                                  Flexible(
                                    child: Text(
                                      "No. of item(s): ${widget.noOfItems}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.placemark_fill,
                                      color: Colors.transparent),
                                  Flexible(
                                    child: Text(
                                      "Amount: ${nF.format(GlobalVariables.cartTotalAmt)}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 3.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.creditcard),
                                  Text(
                                    "  Payment Method",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.creditcard,
                                      color: Colors.transparent),
                                  Flexible(
                                    child: Text(
                                      "${GlobalVariables.selectedPaymentMethod}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Change Payment Method",
                                        style: TextStyle(color: brandingColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                await customPaymentMethodModal(context);
                                if (mounted) setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 3.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0),
                              child: Row(
                                children: [
                                  Icon(CupertinoIcons.money_dollar_circle),
                                  Text(
                                    "  Total Amount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${nF.format(totalAmount)}",
                                      style: TextStyle(
                                        color: brandingColor,
                                        fontSize: ScreenUtil().setSp(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
                      child: MaterialButton(
                        minWidth: size.width,
                        color: brandingColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Place order",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          customLogicalModal(
                              context,
                              Text(
                                  "You cannot cancel or modify your order after this. Continue to place order ?"),
                              () => Navigator.pop(context), () {
                            Navigator.pop(context);
                            startSaving();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  startSaving() async {
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
    connectionChecingStatus = "Saving";
    if (mounted) setState(() {});

    print(GlobalVariables.selectedPaymentMethod);
    print(widget.noOfItems.toString());
    print(totalAmount.toString());
    print(GlobalVariables.customerCartToCheckout);

    var h = await saveOrder(
        context,
        GlobalVariables.selectedPaymentMethod,
        widget.noOfItems.toString(),
        totalAmount.toString(),
        GlobalVariables.customerCartToCheckout);

    GlobalVariables.logcustomerCurrentCredit =
        GlobalVariables.logcustomerCurrentCredit + totalAmount;

    print("result here");
    print(h);

    connectionChecking = false;
    connectionChecingStatus = "";
    if (mounted) setState(() {});
    Navigator.pop(context);

    if (h == true) {
      customModal(
          context,
          Icon(CupertinoIcons.checkmark_alt, size: 50, color: Colors.green),
          Text("Order successfully placed.", textAlign: TextAlign.center),
          false,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          'Okay', () {
        GlobalVariables.orderPlaced = true;
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  startSaving_() async {
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
    connectionChecingStatus = "Saving";
    if (mounted) setState(() {});

    var hTran = await saveOrderTranHead(
        context,
        GlobalVariables.selectedPaymentMethod,
        widget.noOfItems.toString(),
        totalAmount.toString());
    if (hTran != null) {
      GlobalVariables.logcustomerCurrentCredit =
          GlobalVariables.logcustomerCurrentCredit + totalAmount;
      var sveLine = 0;
      for (int i = 0; i < GlobalVariables.customerCartToCheckout.length; i++) {
        await saveOrderTranLine(
            context,
            hTran[0]['tran_no'],
            GlobalVariables.customerCartToCheckout[i]['item_code'],
            GlobalVariables.customerCartToCheckout[i]['description'],
            GlobalVariables.customerCartToCheckout[i]['item_qty'],
            GlobalVariables.customerCartToCheckout[i]['item_uom'],
            GlobalVariables.customerCartToCheckout[i]['list_price_wtax'],
            (double.parse(GlobalVariables.customerCartToCheckout[i]
                        ['list_price_wtax']) *
                    double.parse(
                        GlobalVariables.customerCartToCheckout[i]['item_qty']))
                .toString());
        sveLine = sveLine + 1;
        if (sveLine == GlobalVariables.customerCartToCheckout.length) {
          await deleteCartChk1(context);

          connectionChecking = false;
          connectionChecingStatus = "";
          if (mounted) setState(() {});
          Navigator.pop(context);
          customModal(
              context,
              Icon(CupertinoIcons.checkmark_alt, size: 50, color: Colors.green),
              Text("Order(${hTran[0]['tran_no']}) successfully placed.",
                  textAlign: TextAlign.center),
              false,
              Icon(
                CupertinoIcons.checkmark_alt,
                size: 25,
                color: Colors.greenAccent,
              ),
              'Okay', () {
            GlobalVariables.orderPlaced = true;
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      }
    }
  }
}
