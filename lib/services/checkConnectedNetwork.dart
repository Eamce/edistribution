import 'package:connectivity/connectivity.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> checkConnectedNetwork(BuildContext context) async {
  var returnValue = 'DATAWIFIOFF';
  GlobalVariables.connected = false;
  var connectivityResult = await (Connectivity().checkConnectivity());
  print(connectivityResult);
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    var rsp = await checkConnection(context);
    print(rsp);
    if (rsp == "OKAY") {
      GlobalVariables.connected = true;
      returnValue = 'OKAY';
    } else {
      returnValue = 'ERROR';
    }
  }

  if (returnValue == 'DATAWIFIOFF') {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("No internet connection detected.", textAlign: TextAlign.center),
        false,
        Icon(
          CupertinoIcons.checkmark,
          size: 25,
          color: Colors.green,
        ),
        'Okay', () {
      Navigator.pop(context);
    });
  }

  print(GlobalVariables.connected);
  return returnValue;
}
