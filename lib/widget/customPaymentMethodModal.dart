import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customPaymentMethodModal(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (context) {
      var size = MediaQuery.of(context).size;
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) =>
              WillPopScope(
                onWillPop: () async => false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            child: Text(
                              "Payment Method",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.money_dollar,
                                            color: Colors.deepOrange),
                                        Text(
                                          "Cash on Delivery",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Spacer(),
                                        GlobalVariables.selectedPaymentMethod ==
                                                'Cash on Delivery'
                                            ? Icon(
                                                CupertinoIcons
                                                    .checkmark_alt_circle_fill,
                                                color: Colors.green)
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    GlobalVariables.selectedPaymentMethod =
                                        'Cash on Delivery';
                                    modalState(() {});
                                  },
                                ),
                                // Divider(),
                                // InkWell(
                                //   highlightColor: Colors.transparent,
                                //   splashColor: Colors.transparent,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 10.0, bottom: 10.0),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Icon(CupertinoIcons.creditcard,
                                //             color: Colors.deepOrange),
                                //         Text(
                                //           "Credit Card/Debit Card/PayMaya",
                                //           style: TextStyle(color: Colors.black),
                                //         ),
                                //         Spacer(),
                                //         GlobalVariables.selectedPaymentMethod ==
                                //                 'Credit Card/Debit Card/PayMaya'
                                //             ? Icon(
                                //                 CupertinoIcons
                                //                     .checkmark_alt_circle_fill,
                                //                 color: Colors.green)
                                //             : SizedBox(),
                                //       ],
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     GlobalVariables.selectedPaymentMethod =
                                //         'Credit Card/Debit Card/PayMaya';
                                //     modalState(() {});
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              minWidth: size.width,
                              color: Colors.deepOrange,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                child: Text(
                                  "CONFIRM",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    },
  );
}
