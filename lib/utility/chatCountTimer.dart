import 'dart:async';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/notification.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/material.dart';

class ChatCountTimer {
  void initializeTimer(BuildContext context) {
    startChatCount(context);
  }

  startChatCount(BuildContext context) {
    print('Setting to 5 seconds');
    print('Check Chat Count starts');
    GlobalVariables.timerChatCount =
        Timer.periodic(Duration(seconds: 1), (Timer t) => chatCount(context));
  }

  cancelChatCount() {
    if (GlobalVariables.timerChatCount != null) {
      print('Cancelling Chat Count');
      GlobalVariables.timerChatCount?.cancel();
    }
  }

  chatCount(BuildContext context) async {
    NotificationService notificationService = NotificationService();
    var res = await getChatCount(context);
    List lst = res;
    // print('unseen mesg(down)');
    // print(lst);
    if (lst.length > 0) {
      GlobalVariables.chatCount = int.parse(lst.length.toString());
      var sender =
          'New message from ${lst[lst.length - 1]['sender'].toString().toUpperCase()}';
      var msg = 'Message: ${lst[lst.length - 1]['msg_body']}';
      notificationService.initialize();
      notificationService.instantNotification(
          int.parse(lst[lst.length - 1]['id']), sender, msg);
    } else {
      GlobalVariables.chatCount = 0;
      notificationService.cancelNotification();
    }
  }
}
