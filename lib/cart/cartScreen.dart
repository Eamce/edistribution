import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:edistribution/auth/login/loginScreen.dart';
import 'package:edistribution/cart/checkOut.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:edistribution/widget/customLogicalModal.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:edistribution/extensions/myExtensionString.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');

  bool doneQuery = false;

  bool updating = false;
  int noOfItems = 0;

  double cusRating = 0.0;
  bool sendingRate = false;

  @override
  void initState() {
    super.initState();
    if (GlobalVariables.logcustomerCode.isEmpty) {
      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: LoginScreen()));
    } else {
      GlobalVariables.customerCart = [];
      check();
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
                GlobalVariables.customerCart.length > 0 ? SizedBox() : Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    "My Cart",
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(15)),
                  ),
                ),
                GlobalVariables.customerCart.length > 0 ? Spacer() : SizedBox(),
                GlobalVariables.customerCart.length > 0
                    ? InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(15)),
                          ),
                        ),
                        onTap: () {
                          if (GlobalVariables.cartTotalAmt > 0) {
                            if (GlobalVariables.cartTotalAmt >=
                                GlobalVariables.minOrderLimit) {
                              if (GlobalVariables.logcustomerApplyCreditLimit ==
                                  true) {
                                //with credit limit
                                if (GlobalVariables.logcustomerCreditLimit >
                                    (GlobalVariables.logcustomerCurrentCredit +
                                        GlobalVariables.cartTotalAmt)) {
                                  //not over on credit limit
                                  customLogicalModal(
                                      context,
                                      Text(
                                          "Review and check first your cart if all products are correct before checking out. Continue to check out ?"),
                                      () => Navigator.pop(context), () {
                                    GlobalVariables.customerCartToCheckout = [];
                                    GlobalVariables.customerCartToCheckout =
                                        List.from(GlobalVariables.customerCart);
                                    GlobalVariables.customerCartToCheckout
                                        .removeWhere(
                                            (element) => element["chk"] == '0');
                                    print(
                                        GlobalVariables.customerCartToCheckout);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: CheckOut(
                                              noOfItems: noOfItems,
                                            ))).then((value) {
                                      if (GlobalVariables.orderPlaced == true) {
                                        doneQuery = false;
                                        updating = false;
                                        noOfItems = 0;
                                        GlobalVariables.customerCart = [];
                                        if (mounted) setState(() {});
                                        check();
                                        GlobalVariables.orderPlaced = false;
                                        showRating();
                                      }
                                    });
                                  });
                                } else {
                                  //over on credit limit
                                  customModal(
                                      context,
                                      Icon(
                                          CupertinoIcons.exclamationmark_circle,
                                          size: 50,
                                          color: Colors.red),
                                      Text(
                                          "Sorry, credit limit has been exceeded: Current credit(${nF.format(GlobalVariables.logcustomerCurrentCredit)}, Allowed credit(${nF.format(GlobalVariables.logcustomerCreditLimit)}).",
                                          textAlign: TextAlign.center),
                                      true,
                                      Icon(
                                        CupertinoIcons.checkmark_alt,
                                        size: 25,
                                        color: Colors.greenAccent,
                                      ),
                                      '',
                                      () {});
                                }
                              } else {
                                //without credit limit
                                customLogicalModal(
                                    context,
                                    Text(
                                        "Review and check first your cart if all products are correct before checking out. Continue to check out ?"),
                                    () => Navigator.pop(context), () {
                                  GlobalVariables.customerCartToCheckout = [];
                                  GlobalVariables.customerCartToCheckout =
                                      List.from(GlobalVariables.customerCart);
                                  GlobalVariables.customerCartToCheckout
                                      .removeWhere(
                                          (element) => element["chk"] == '0');
                                  print(GlobalVariables.customerCartToCheckout);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CheckOut(
                                            noOfItems: noOfItems,
                                          ))).then((value) {
                                    if (GlobalVariables.orderPlaced == true) {
                                      doneQuery = false;
                                      updating = false;
                                      noOfItems = 0;
                                      GlobalVariables.customerCart = [];
                                      if (mounted) setState(() {});
                                      check();
                                      GlobalVariables.orderPlaced = false;
                                      showRating();
                                    }
                                  });
                                });
                              }
                            } else {
                              customModal(
                                  context,
                                  Icon(CupertinoIcons.exclamationmark_circle,
                                      size: 50, color: Colors.red),
                                  Text(
                                      "Minimum order amount should be ${nF.format(GlobalVariables.minOrderLimit)}. Currently, you reached ${nF.format(GlobalVariables.cartTotalAmt)} in your cart.",
                                      textAlign: TextAlign.center),
                                  true,
                                  Icon(
                                    CupertinoIcons.checkmark_alt,
                                    size: 25,
                                    color: Colors.greenAccent,
                                  ),
                                  '',
                                  () {});
                            }
                          } else {
                            customModal(
                                context,
                                Icon(CupertinoIcons.exclamationmark_circle,
                                    size: 50, color: Colors.red),
                                Text("Nothing to checkout.",
                                    textAlign: TextAlign.center),
                                true,
                                Icon(
                                  CupertinoIcons.checkmark_alt,
                                  size: 25,
                                  color: Colors.greenAccent,
                                ),
                                '',
                                () {});
                          }
                        },
                      )
                    : SizedBox(),
                GlobalVariables.customerCart.length > 0 ? SizedBox() : Spacer(),
              ],
            ),
          ),
          doneQuery ? SizedBox() : Spacer(),
          GlobalVariables.customerCart.length > 0
              ? Container(
                  width: size.width,
                  color: Colors.greenAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Minimum order amount should be ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "${nF.format(GlobalVariables.minOrderLimit)}",
                            style: TextStyle(
                              color: brandingColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ". Currently, you reached",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: " ${nF.format(GlobalVariables.cartTotalAmt)}",
                            style: TextStyle(
                              color: brandingColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " in your cart.",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          doneQuery
              ? GlobalVariables.customerCart.length > 0
                  ? Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return false;
                        },
                        child: Scrollbar(
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: GlobalVariables.customerCart.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, right: 3.0, top: 3.0),
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Checkbox(
                                              value:
                                                  GlobalVariables.customerCart[
                                                              index]['chk'] ==
                                                          '1'
                                                      ? true
                                                      : false,
                                              onChanged: (val) async {
                                                showDialog<String>(
                                                  barrierDismissible: false,
                                                  barrierColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          WillPopScope(
                                                    onWillPop: () async =>
                                                        false,
                                                    child: AlertDialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0.0,
                                                    ),
                                                  ),
                                                );
                                                updating = true;
                                                if (mounted) setState(() {});
                                                val == true
                                                    ? GlobalVariables
                                                            .customerCart[index]
                                                        ['chk'] = "1"
                                                    : GlobalVariables
                                                            .customerCart[index]
                                                        ['chk'] = "0";

                                                var up =
                                                    await updateCustomerCartChk(
                                                        context,
                                                        GlobalVariables
                                                                .customerCart[
                                                            index]['item_code'],
                                                        GlobalVariables
                                                                .customerCart[
                                                            index]['item_uom'],
                                                        GlobalVariables.customerCart[
                                                                        index]
                                                                    ['chk'] ==
                                                                "1"
                                                            ? 1
                                                            : 0);
                                                if (up == true) {
                                                  totCalculate();
                                                  // var qty = int.parse(
                                                  //     GlobalVariables
                                                  //             .customerCart[
                                                  //         index]['item_qty']);
                                                  // GlobalVariables.customerCart[
                                                  //             index]['chk'] ==
                                                  //         "1"
                                                  //     ? GlobalVariables
                                                  //             .cartItemCount =
                                                  //         GlobalVariables
                                                  //                 .cartItemCount +
                                                  //             qty
                                                  //     : GlobalVariables
                                                  //             .cartItemCount =
                                                  //         GlobalVariables
                                                  //                 .cartItemCount -
                                                  //             qty;
                                                  Navigator.pop(context);
                                                  updating = false;
                                                  if (mounted) setState(() {});
                                                } else {
                                                  Navigator.pop(context);
                                                  updating = false;
                                                  if (mounted) setState(() {});
                                                }
                                              }),
                                          InkWell(
                                              onTap: () {
                                                delete(
                                                    GlobalVariables
                                                            .customerCart[index]
                                                        ['item_code'],
                                                    GlobalVariables
                                                            .customerCart[index]
                                                        ['item_uom'],
                                                    index,
                                                    int.parse(GlobalVariables
                                                            .customerCart[index]
                                                        ['item_qty']));
                                              },
                                              child:
                                                  Icon(CupertinoIcons.trash)),
                                        ],
                                      ),
                                      Container(
                                        height: size.height / 10,
                                        width: size.height / 10,
                                        color: Colors.white,
                                        child: CachedNetworkImage(
                                          imageUrl: ServerUrl.itmImgUrl +
                                              GlobalVariables
                                                      .customerCart[index]
                                                  ['item_path'],
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error,
                                                  color: Colors.grey[200]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // height: size.height / 15,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                    GlobalVariables
                                                            .customerCart[index]
                                                        ['description'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0, right: 3.0),
                                                child: Text(
                                                    GlobalVariables
                                                            .customerCart[index]
                                                        ['item_uom'],
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                    '${GlobalVariables.product50[index]['list_price_wtax'].toString().toCurrencyFormat}',
                                                    style: TextStyle(
                                                        color: brandingColor),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height:
                                                            size.height / 35,
                                                        width: size.height / 35,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                brandingColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .minus,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onTap: () async {
                                                        if (int.parse(GlobalVariables
                                                                        .customerCart[
                                                                    index]
                                                                ['item_qty']) >
                                                            1) {
                                                          showDialog<String>(
                                                            barrierDismissible:
                                                                false,
                                                            barrierColor: Colors
                                                                .transparent,
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                WillPopScope(
                                                              onWillPop:
                                                                  () async =>
                                                                      false,
                                                              child:
                                                                  AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                elevation: 0.0,
                                                              ),
                                                            ),
                                                          );
                                                          updating = true;
                                                          if (mounted)
                                                            setState(() {});
                                                          print(GlobalVariables
                                                                  .customerCart[
                                                              index]['item_qty']);

                                                          var up = await updateCustomerCartQty(
                                                              context,
                                                              GlobalVariables
                                                                          .customerCart[
                                                                      index]
                                                                  ['item_code'],
                                                              GlobalVariables
                                                                          .customerCart[
                                                                      index]
                                                                  ['item_uom'],
                                                              (int.parse(GlobalVariables
                                                                              .customerCart[index]
                                                                          [
                                                                          'item_qty']) -
                                                                      1)
                                                                  .toString());

                                                          if (up == true) {
                                                            GlobalVariables.customerCart[
                                                                        index][
                                                                    'item_qty'] =
                                                                "${int.parse(GlobalVariables.customerCart[index]['item_qty']) - 1}";
                                                            await totCalculate();
                                                            // noOfItems =
                                                            //     noOfItems - 1;
                                                            // GlobalVariables
                                                            //         .cartItemCount =
                                                            //     GlobalVariables
                                                            //             .cartItemCount -
                                                            //         1;
                                                            if (mounted)
                                                              setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                            updating = false;
                                                            if (mounted)
                                                              setState(() {});
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                            updating = false;
                                                            if (mounted)
                                                              setState(() {});
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 15.0,
                                                                left: 15.0),
                                                        child: Text(
                                                          "${GlobalVariables.customerCart[index]['item_qty']}",
                                                        )),
                                                    InkWell(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height:
                                                            size.height / 35,
                                                        width: size.height / 35,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                brandingColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                        child: Icon(
                                                            CupertinoIcons.plus,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onTap: () async {
                                                        if (int.parse(GlobalVariables
                                                                        .customerCart[
                                                                    index]
                                                                ['item_qty']) <
                                                            100) {
                                                          showDialog<String>(
                                                            barrierDismissible:
                                                                false,
                                                            barrierColor: Colors
                                                                .transparent,
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                WillPopScope(
                                                              onWillPop:
                                                                  () async =>
                                                                      false,
                                                              child:
                                                                  AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                elevation: 0.0,
                                                              ),
                                                            ),
                                                          );
                                                          updating = true;
                                                          if (mounted)
                                                            setState(() {});
                                                          print(GlobalVariables
                                                                  .customerCart[
                                                              index]['item_qty']);
                                                          var up = await updateCustomerCartQty(
                                                              context,
                                                              GlobalVariables
                                                                          .customerCart[
                                                                      index]
                                                                  ['item_code'],
                                                              GlobalVariables
                                                                          .customerCart[
                                                                      index]
                                                                  ['item_uom'],
                                                              (int.parse(GlobalVariables
                                                                              .customerCart[index]
                                                                          [
                                                                          'item_qty']) +
                                                                      1)
                                                                  .toString());
                                                          if (up == true) {
                                                            // await totCalculate();
                                                            GlobalVariables.customerCart[
                                                                        index][
                                                                    'item_qty'] =
                                                                "${int.parse(GlobalVariables.customerCart[index]['item_qty']) + 1}";
                                                            await totCalculate();
                                                            // noOfItems =
                                                            //     noOfItems + 1;
                                                            // GlobalVariables
                                                            //         .cartItemCount =
                                                            //     GlobalVariables
                                                            //             .cartItemCount +
                                                            //         1;
                                                            if (mounted)
                                                              setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                            updating = false;
                                                            if (mounted)
                                                              setState(() {});
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                            updating = false;
                                                            if (mounted)
                                                              setState(() {});
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                        "${nF.format(int.parse(GlobalVariables.customerCart[index]['item_qty']) * double.parse(GlobalVariables.customerCart[index]['list_price_wtax']))}",
                                                        style: TextStyle(
                                                            color:
                                                                brandingColor)),
                                                  ],
                                                ),
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
              : loadingCart(),
          doneQuery ? SizedBox() : Spacer(),
          GlobalVariables.customerCart.length > 0
              ? Padding(
                  padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                  child: Container(
                    color: Colors.white,
                    height: bottomPadding + bottomPadding,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          updating == true
                              ? LinearProgressIndicator()
                              : SizedBox(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("No. of Item(s): $noOfItems"),
                              Spacer(),
                              Text(
                                "${nF.format(GlobalVariables.cartTotalAmt)}",
                                style: TextStyle(
                                    color: brandingColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget loadingCart() {
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
          Text("Empty cart"),
        ],
      ),
    );
  }

  check() async {
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      var cart = await getCustomerCart(context);
      if (cart != null) {
        GlobalVariables.customerCart = cart;
        await totCalculate();
        doneQuery = true;
        if (mounted) setState(() {});
      } else {
        doneQuery = true;
        if (mounted) setState(() {});
      }
    }
  }

  totCalculate() async {
    GlobalVariables.cartTotalAmt = 0.0;
    noOfItems = 0;
    for (int i = 0; i < GlobalVariables.customerCart.length; i++) {
      if (GlobalVariables.customerCart[i]['chk'] == '1') {
        print('c');
        GlobalVariables.cartTotalAmt = GlobalVariables.cartTotalAmt +
            (int.parse(GlobalVariables.customerCart[i]['item_qty']) *
                double.parse(
                    GlobalVariables.customerCart[i]['list_price_wtax']));

        noOfItems =
            noOfItems + int.parse(GlobalVariables.customerCart[i]['item_qty']);
        if (mounted) setState(() {});
      }
    }
    print(GlobalVariables.cartTotalAmt);
  }

  delete(String itemcode, String uom, int index, int qty) async {
    updating = true;
    if (mounted) setState(() {});
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

    customLogicalModal(
      context,
      Text("Delete this product in your cart?"),
      () {
        Navigator.pop(context);
        Navigator.pop(context);
        updating = false;
        if (mounted) setState(() {});
      },
      () async {
        Navigator.pop(context);
        var res = await deleteProductCart(context, itemcode, uom);
        if (res == true) {
          customModal(
              context,
              Icon(CupertinoIcons.info_circle, size: 50, color: Colors.blue),
              Text("Deleted successfully.", textAlign: TextAlign.center),
              false,
              Icon(
                CupertinoIcons.checkmark,
                size: 25,
                color: Colors.green,
              ),
              'Okay', () {
            Navigator.pop(context);

            GlobalVariables.customerCart.removeAt(index);
            totCalculate();

            updating = false;
            Navigator.pop(context);
            if (mounted) setState(() {});
          });
        } else {
          updating = false;
          Navigator.pop(context);
          if (mounted) setState(() {});
        }
      },
    );
  }

  showRating() async {
    var size = MediaQuery.of(context).size;
    if (GlobalVariables.logcustomerAppRate == 0) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(builder: (context, dialogState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                      child: Text(
                        "DO YOU LIKE OUR APP?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 25),
                      child: Text(
                          "Rate your experience using My NETgosyo so far."),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: RatingBar.builder(
                        initialRating: 0,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                CommunityMaterialIcons.emoticon_dead_outline,
                                color: Colors.red,
                              );
                            case 1:
                              return Icon(
                                CommunityMaterialIcons.emoticon_sad_outline,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return Icon(
                                CommunityMaterialIcons.emoticon_neutral_outline,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                CommunityMaterialIcons.emoticon_happy_outline,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                CommunityMaterialIcons.emoticon_excited_outline,
                                color: Colors.green,
                              );
                            default:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                          }
                        },
                        onRatingUpdate: (rating) {
                          print(rating);
                          cusRating = rating;
                        },
                      ),
                    ),
                    sendingRate ? LinearProgressIndicator() : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Container(
                              width: size.width / 3,
                              height: size.height / 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Spacer(),
                                  Icon(
                                    CupertinoIcons.xmark,
                                    size: 25,
                                    color: Colors.redAccent,
                                  ),
                                  Text("Not Now"),
                                  Spacer(),
                                ],
                              ),
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                          InkWell(
                            child: Container(
                              width: size.width / 3,
                              height: size.height / 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Spacer(),
                                  Icon(
                                    CupertinoIcons.checkmark_alt,
                                    size: 25,
                                    color: Colors.greenAccent,
                                  ),
                                  Text("Submit"),
                                  Spacer(),
                                ],
                              ),
                            ),
                            onTap: () async {
                              if (cusRating > 0) {
                                sendingRate = true;
                                dialogState(() {});
                                await sendAppRate(context, cusRating.round());
                                GlobalVariables.logcustomerAppRate =
                                    cusRating.round();
                                sendingRate = false;
                                dialogState(() {});
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    }
  }
}
