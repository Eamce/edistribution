import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trustfall extends StatelessWidget {
  const Trustfall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.exclamationmark_shield_fill,
                    color: Colors.red, size: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        Platform.isAndroid
                            ? "Rooted Device Detected"
                            : "Jailbreak Device Detected",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        Platform.isAndroid
                            ? "We are sorry but due to security concerns, MyNETgosyo cannot be used on rooted devices."
                            : "We are sorry but due to security concerns, MyNETgosyo cannot be used on jailbreak devices.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
