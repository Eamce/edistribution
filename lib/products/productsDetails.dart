import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/auth/login/loginScreen.dart';
import 'package:edistribution/products/suggestedProducts.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

productDetails(BuildContext context, bool isDismissible, String image,
    String desc, double cost, String keyword, String family, bool forSimilar) {
  var selectedUnitIndex = 0;
  var qty = 1;
  var total = cost;
  var sold = GlobalVariables.productDetails[0][0]['sold'];
  var fav = GlobalVariables.productDetails[0][0]['fav'];
  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');
  var size = MediaQuery.of(context).size;
  bool saving = false;
  bool done = false;
  bool savingFav = false;
  List ls = [];

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    if (GlobalVariables.logcustomerCode.isNotEmpty) {
      sessionTimer.initializeTimer(context);
    }
  }

  return showModalBottomSheet(
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    context: context,
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: handleUserInteraction,
        onPanDown: handleUserInteraction,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return WillPopScope(
            onWillPop: () async => isDismissible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: !saving
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: ServerUrl.itmImgUrl + image,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.grey[200]),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(desc,
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(15)),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              "${NumberFormat.compact().format(int.parse(sold))} sold",
                              style: TextStyle(
                                  color: int.parse(sold) > 0
                                      ? Colors.grey
                                      : Colors.white),
                            ),
                          ),
                          Container(
                            height: size.height / 15,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowIndicator();
                                  return false;
                                },
                                child: ListView.builder(
                                  itemCount:
                                      GlobalVariables.productDetails[0].length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: MaterialButton(
                                        elevation: 0.0,
                                        color: selectedUnitIndex == index
                                            ? Colors.deepOrange[300]
                                            : Colors.grey[200],
                                        child: Text(
                                            GlobalVariables.productDetails[0]
                                                [index]['uom'],
                                            style: TextStyle(
                                                color:
                                                    selectedUnitIndex == index
                                                        ? Colors.white
                                                        : Colors.black)),
                                        onPressed: () {
                                          selectedUnitIndex = index;
                                          cost = double.parse(
                                              GlobalVariables.productDetails[0]
                                                  [index]['list_price_wtax']);
                                          total = qty * cost;
                                          sold = GlobalVariables
                                              .productDetails[0][index]['sold'];
                                          fav = GlobalVariables
                                              .productDetails[0][index]['fav'];
                                          setModalState(() {});
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height / 25,
                                    width: size.height / 25,
                                    decoration: BoxDecoration(
                                        color: brandingColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Icon(CupertinoIcons.minus,
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    if (qty > 1) {
                                      qty = qty - 1;
                                      total = qty * cost;
                                      setModalState(() {});
                                    }
                                  },
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15.0, left: 15.0),
                                    child: Text("$qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: size.height / 25,
                                    width: size.height / 25,
                                    decoration: BoxDecoration(
                                        color: brandingColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Icon(CupertinoIcons.plus,
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    if (qty < 100) {
                                      qty = qty + 1;
                                      total = qty * cost;
                                      setModalState(() {});
                                    }
                                  },
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0.0, left: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: brandingColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: MaterialButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Text("${nF.format(total)}",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            Spacer(),
                                            Icon(CupertinoIcons.cart_badge_plus,
                                                color: Colors.white)
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (GlobalVariables
                                              .logcustomerCode.isNotEmpty) {
                                            if (GlobalVariables
                                                            .productDetails[0]
                                                        [selectedUnitIndex]
                                                    ['status'] ==
                                                '1') {
                                              // Navigator.pop(context);
                                              saving = true;
                                              setModalState(() {});
                                              var res = await getSpcfcproductCart(
                                                  context,
                                                  GlobalVariables
                                                      .logcustomerCode,
                                                  GlobalVariables
                                                              .productDetails[0]
                                                          [selectedUnitIndex]
                                                      ['itemcode'],
                                                  GlobalVariables
                                                              .productDetails[0]
                                                          [selectedUnitIndex]
                                                      ['uom']);
                                              ls = res;
                                              done = true;
                                              setModalState(() {});
                                              if (ls.length == 0) {
                                                await insertOnCart(
                                                    context,
                                                    GlobalVariables
                                                        .logcustomerCode,
                                                    GlobalVariables
                                                                .productDetails[
                                                            0][selectedUnitIndex]
                                                        ['itemcode'],
                                                    GlobalVariables
                                                                .productDetails[
                                                            0][selectedUnitIndex]
                                                        ['uom'],
                                                    qty);
                                                Navigator.pop(context);
                                                customModal(
                                                    context,
                                                    Icon(
                                                        CupertinoIcons
                                                            .checkmark_alt,
                                                        size: 50,
                                                        color: Colors.green),
                                                    Text(
                                                        "Added to cart successfully.",
                                                        textAlign:
                                                            TextAlign.center),
                                                    true,
                                                    Icon(
                                                      CupertinoIcons
                                                          .checkmark_alt,
                                                      size: 25,
                                                      color: Colors.greenAccent,
                                                    ),
                                                    'Okay',
                                                    () {});
                                              }
                                            } else {
                                              customModal(
                                                  context,
                                                  Icon(
                                                      CupertinoIcons
                                                          .exclamationmark_circle,
                                                      size: 50,
                                                      color: Colors.red),
                                                  Text(
                                                      "Sorry, this product was tagged as OUT OF STOCK.",
                                                      textAlign:
                                                          TextAlign.center),
                                                  true,
                                                  Icon(
                                                    CupertinoIcons
                                                        .checkmark_alt,
                                                    size: 25,
                                                    color: Colors.greenAccent,
                                                  ),
                                                  '', () {
                                                Navigator.pop(context);
                                              });
                                            }
                                          } else {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: LoginScreen()));
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                !forSimilar
                                    ? MaterialButton(
                                        height: size.height / 15,
                                        minWidth: size.width / 10,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(CupertinoIcons.eye),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: SuggestedProducts(
                                                    itemcode: GlobalVariables
                                                            .productDetails[0]
                                                        [0]['itemcode'],
                                                    family: family,
                                                    keyword: keyword,
                                                  )));
                                        },
                                      )
                                    : SizedBox(),
                                GlobalVariables.logcustomerCode.isNotEmpty
                                    ? MaterialButton(
                                        height: size.height / 15,
                                        minWidth: size.width / 10,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: savingFav == false
                                            ? Icon(
                                                fav ==
                                                        GlobalVariables
                                                            .logcustomerCode
                                                    ? CupertinoIcons.heart_fill
                                                    : CupertinoIcons.heart,
                                                color: fav ==
                                                        GlobalVariables
                                                            .logcustomerCode
                                                    ? Colors.red
                                                    : Colors.black,
                                              )
                                            : Container(
                                                height: 15,
                                                width: 15,
                                                child:
                                                    CircularProgressIndicator()),
                                        onPressed: () async {
                                          if (savingFav == false) {
                                            if (fav ==
                                                GlobalVariables
                                                    .logcustomerCode) {
                                              savingFav = true;
                                              setModalState(() {});
                                              await insertremoveFavorites(
                                                context,
                                                GlobalVariables
                                                            .productDetails[0]
                                                        [selectedUnitIndex]
                                                    ['itemcode'],
                                                'remove',
                                              );
                                              GlobalVariables.productDetails[0]
                                                      [selectedUnitIndex]
                                                  ['fav'] = 'null';
                                              fav = 'null';
                                              savingFav = false;
                                              setModalState(() {});
                                            } else {
                                              savingFav = true;
                                              setModalState(() {});
                                              await insertremoveFavorites(
                                                  context,
                                                  GlobalVariables
                                                              .productDetails[0]
                                                          [selectedUnitIndex]
                                                      ['itemcode'],
                                                  'insert');
                                              GlobalVariables.productDetails[0]
                                                          [selectedUnitIndex]
                                                      ['fav'] =
                                                  GlobalVariables
                                                      .logcustomerCode;
                                              fav = GlobalVariables
                                                  .logcustomerCode;
                                              savingFav = false;
                                              setModalState(() {});
                                            }
                                          }
                                        },
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !done
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ls.length > 0
                                          ? Text(
                                              "$desc(${GlobalVariables.productDetails[0][selectedUnitIndex]['uom']}) was already at your cart having ${ls[0]['item_qty']} quantity. Continue to add?")
                                          : Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      ls.length > 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  highlightColor:
                                                      Colors.transparent,
                                                  splashColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                    width: size.width / 3,
                                                    height: size.height / 20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Spacer(),
                                                        Icon(
                                                          CupertinoIcons.xmark,
                                                          size: 25,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Text("No"),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                InkWell(
                                                  highlightColor:
                                                      Colors.transparent,
                                                  splashColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                    width: size.width / 3,
                                                    height: size.height / 20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Spacer(),
                                                        Icon(
                                                          CupertinoIcons
                                                              .checkmark_alt,
                                                          size: 25,
                                                          color: Colors
                                                              .greenAccent,
                                                        ),
                                                        Text("Yes"),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    done = false;
                                                    setModalState(() {});
                                                    await insertOnCart(
                                                        context,
                                                        GlobalVariables
                                                            .logcustomerCode,
                                                        GlobalVariables
                                                                    .productDetails[0]
                                                                [
                                                                selectedUnitIndex]
                                                            ['itemcode'],
                                                        GlobalVariables
                                                                .productDetails[0]
                                                            [
                                                            selectedUnitIndex]['uom'],
                                                        qty);
                                                    Navigator.pop(context);
                                                    customModal(
                                                        context,
                                                        Icon(
                                                            CupertinoIcons
                                                                .checkmark_alt,
                                                            size: 50,
                                                            color:
                                                                Colors.green),
                                                        Text(
                                                            "Cart updated successfully.",
                                                            textAlign: TextAlign
                                                                .center),
                                                        true,
                                                        Icon(
                                                          CupertinoIcons
                                                              .checkmark_alt,
                                                          size: 25,
                                                          color: Colors
                                                              .greenAccent,
                                                        ),
                                                        'Okay',
                                                        () {});
                                                  },
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          );
        }),
      );
    },
  );
}

Widget qtyButton(BuildContext context, IconData icon, Function fn) {
  var size = MediaQuery.of(context).size;
  return InkWell(
    child: Container(
      alignment: Alignment.center,
      height: size.height / 25,
      width: size.height / 25,
      decoration: BoxDecoration(
          color: brandingColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Icon(icon, color: Colors.white),
    ),
    onTap: () => fn,
  );
}
