import 'dart:async';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/material.dart';

class CartCountTimer {
  void initializeTimer(BuildContext context) {
    startCartCount(context);
  }

  startCartCount(BuildContext context) {
    print('Setting to 5 seconds');
    print('Check Cart Count starts');
    GlobalVariables.timerCartCount =
        Timer.periodic(Duration(seconds: 5), (Timer t) => cartCount(context));
  }

  cancelCartCount() {
    if (GlobalVariables.timerCartCount != null) {
      print('Cancelling Cart Count');
      GlobalVariables.timerCartCount?.cancel();
    }
  }

  cartCount(BuildContext context) async {
    var res = await getCartItemCount(context);
    GlobalVariables.cartItemCount =
        int.parse(res['item_qty'] != null ? res['item_qty'] : '0');
  }
}
