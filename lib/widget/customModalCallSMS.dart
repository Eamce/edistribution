import 'package:flutter/material.dart';

customModalCallSMS(BuildContext context, Icon icon, Text msg, Icon iconBtn1,
    String txtBtn1, Function fn1, Icon iconBtn2, String txtBtn2, Function fn2) {
  return showModalBottomSheet(
    isDismissible: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      var size = MediaQuery.of(context).size;
      return WillPopScope(
        onWillPop: () async => true,
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
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0), child: icon),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0), child: msg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Container(
                          width: size.width / 3,
                          height: size.height / 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              iconBtn1,
                              Text(txtBtn1),
                              Spacer(),
                            ],
                          ),
                        ),
                        onTap: () {
                          fn1();
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: size.width / 3,
                          height: size.height / 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              iconBtn2,
                              Text(txtBtn2),
                              Spacer(),
                            ],
                          ),
                        ),
                        onTap: () {
                          fn2();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
