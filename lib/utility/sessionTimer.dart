import 'dart:async';
import 'package:edistribution/menu.dart';
import 'package:edistribution/utility/cartCountTimer.dart';
import 'package:edistribution/utility/chatCountTimer.dart';
import 'package:edistribution/utility/concurrentLoginTimer.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sessiontimer {
  void initializeTimer(BuildContext context) {
    resetTimer(context);
  }

  resetTimer(BuildContext context) {
    CartCountTimer cartCountTimer = CartCountTimer();
    Concurrentlogintimer concurrentlogintimer = Concurrentlogintimer();
    ChatCountTimer chatCountTimer = ChatCountTimer();

    if (GlobalVariables.timerSessionInactivity != null) {
      print('Reset Session Timer');
      GlobalVariables.timerSessionInactivity?.cancel();
    }

    print('Setting to 10 minutes');
    GlobalVariables.timerSessionInactivity =
        Timer(const Duration(minutes: 10), () async {
      //
      print('Session is over');
      if (GlobalVariables.timerSessionInactivity != null) {
        print('Reset Session Timer');
        GlobalVariables.timerSessionInactivity?.cancel();
      }

      cartCountTimer.cancelCartCount();
      concurrentlogintimer.cancelCheckingconcurrentlog();
      chatCountTimer.cancelChatCount();
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.redAccent),
          Text("Your session has expired due to inactivity.",
              textAlign: TextAlign.center),
          false,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          'Okay', () {
        imageCache.clear();
        imageCache.clearLiveImages();
        GlobalVariables.logcustomerCode = '';
        GlobalVariables.menuCurrentIndex = 0;
        GlobalVariables.cartItemCount = 0;
        GlobalVariables.chatCount = 0;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => Menu(),
          ),
          (Route route) =>
              false, //if you want to disable back feature set to false1
        );
      });
      //
    });
  }

  cancelSessiontimer() {
    if (GlobalVariables.timerSessionInactivity != null) {
      print('Cancelling Session Timer');
      GlobalVariables.timerSessionInactivity?.cancel();
    }
  }
}
