import 'dart:async';
import 'package:edistribution/menu.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/utility/cartCountTimer.dart';
import 'package:edistribution/utility/chatCountTimer.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Concurrentlogintimer {
  void initializeTimer(BuildContext context) {
    startCheckingconcurrentlog(context);
  }

  startCheckingconcurrentlog(BuildContext context) {
    print('Setting to 5 seconds');
    print('Check Concurrent Login Timer starts');
    GlobalVariables.timerCheckConcurrentLogIn = Timer.periodic(
        Duration(seconds: 5), (Timer t) => checkCustomerActive(context));
  }

  cancelCheckingconcurrentlog() {
    if (GlobalVariables.timerCheckConcurrentLogIn != null) {
      print('Cancelling Check Concurrent Login Timer');
      GlobalVariables.timerCheckConcurrentLogIn?.cancel();
    }
  }

  checkCustomerActive(BuildContext contextx) async {
    Sessiontimer sessiontimer = Sessiontimer();
    CartCountTimer cartCountTimer = CartCountTimer();
    ChatCountTimer chatCountTimer = ChatCountTimer();

    // var con = await checkConnectedNetwork(GlobalVariables.menuContext!);
    // if (con == 'OKAY') {
    var res = await getActiveDevice(GlobalVariables.menuContext!);
    List device = res;
    // print(res);
    if (device.length > 0) {
      if (device[0]['device'] != GlobalVariables.deviceInfo) {
        sessiontimer.cancelSessiontimer();
        cartCountTimer.cancelCartCount();
        chatCountTimer.cancelChatCount();
        cancelCheckingconcurrentlog();
        customModal(
            GlobalVariables.menuContext!,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.redAccent),
            Text(
                "This session is terminated, because your account is being login from another device(${device[0]['readable_device'].toString().toUpperCase()}).",
                textAlign: TextAlign.center),
            false,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay', () {
          // imageCache!.clear();
          // imageCache!.clearLiveImages();
          GlobalVariables.logcustomerCode = '';
          GlobalVariables.menuCurrentIndex = 0;
          GlobalVariables.cartItemCount = 0;
          GlobalVariables.chatCount = 0;
          Navigator.of(GlobalVariables.menuContext!).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => Menu(),
            ),
            (Route route) =>
                false, //if you want to disable back feature set to false1
          );
        });
      }
    }
    // }
  }
}
