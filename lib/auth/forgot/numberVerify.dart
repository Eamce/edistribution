import 'dart:math';

import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberVerify extends StatefulWidget {
  const NumberVerify({Key? key}) : super(key: key);

  @override
  _NumberVerifyState createState() => _NumberVerifyState();
}

class _NumberVerifyState extends State<NumberVerify> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  final mobileController = TextEditingController();
  final codeController = TextEditingController();

  final _chars = '1234567890';
  Random _rnd = Random();

  bool mobileVerified = false;

  String code = '';

  @override
  void dispose() {
    super.dispose();
    mobileController.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Reset Password",
              style: TextStyle(color: Colors.blueGrey[900])),
          bottom: PreferredSize(
              child: connectionChecking == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        connectionChecingStatus != ''
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  connectionChecingStatus!,
                                  style: TextStyle(
                                      color: Colors.redAccent, fontSize: 10),
                                ),
                              )
                            : SizedBox(),
                        LinearProgressIndicator(),
                      ],
                    )
                  : SizedBox(),
              preferredSize: Size.fromHeight(4.0)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                mobileVerified == false
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                child: Center(
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                child: Text(
                                  "Don't worry! Resetting your password is easy. Just type in your registered mobile number.",
                                  style: TextStyle(color: Colors.blueGrey[900]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 20.0),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"))
                                  ],
                                  maxLength: 11,
                                  controller: mobileController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.blueGrey[900]),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Icon(
                                          CupertinoIcons.device_phone_portrait,
                                          color: Colors.blueGrey[900]),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: mobileController.text.isNotEmpty
                                          ? Icon(
                                              CupertinoIcons.xmark_circle_fill,
                                              color: Colors.redAccent)
                                          : SizedBox(),
                                      onPressed: () {
                                        mobileController.clear();
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black54),
                                    hintText: "Enter Mobile",
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (mounted) setState(() {});
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: MaterialButton(
                                  minWidth: size.width,
                                  color: brandingColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (checkEmptyRequiredField() == false) {
                                      if (checkMobile() == true) {
                                        showDialog<String>(
                                          barrierDismissible: false,
                                          barrierColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              WillPopScope(
                                            onWillPop: () async => false,
                                            child: AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0.0,
                                            ),
                                          ),
                                        );
                                        connectionChecking = true;
                                        connectionChecingStatus =
                                            'Verifying mobile';
                                        if (mounted) setState(() {});
                                        check();
                                      } else {
                                        customModal(
                                            context,
                                            Icon(
                                                CupertinoIcons
                                                    .exclamationmark_circle,
                                                size: 50,
                                                color: Colors.red),
                                            Text(
                                                "Mobile Number format is not valid.",
                                                textAlign: TextAlign.center),
                                            true,
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
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
                                              "Please fill up the required field.",
                                              textAlign: TextAlign.center),
                                          true,
                                          Icon(
                                            CupertinoIcons.checkmark_alt,
                                            size: 25,
                                            color: Colors.greenAccent,
                                          ),
                                          'Okay',
                                          () {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                mobileVerified == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                child: Center(
                                  child: Text(
                                    "Verification Code",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8.0, right: 8.0),
                                child: Text(
                                  "Verification code has been sent to mobile number you registered.",
                                  style: TextStyle(color: Colors.blueGrey[900]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 20.0),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"))
                                  ],
                                  maxLength: 6,
                                  controller: codeController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.blueGrey[900]),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Icon(
                                          CupertinoIcons.circle_grid_hex,
                                          color: Colors.blueGrey[900]),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: codeController.text.isNotEmpty
                                          ? Icon(
                                              CupertinoIcons.xmark_circle_fill,
                                              color: Colors.redAccent)
                                          : SizedBox(),
                                      onPressed: () {
                                        codeController.clear();
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black54),
                                    hintText: "Enter Code",
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (mounted) setState(() {});
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: MaterialButton(
                                  minWidth: size.width,
                                  color: brandingColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (checkEmptyRequiredFieldCode() ==
                                        false) {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        barrierColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            WillPopScope(
                                          onWillPop: () async => false,
                                          child: AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0,
                                          ),
                                        ),
                                      );
                                      connectionChecking = true;
                                      connectionChecingStatus =
                                          'Verifying code';
                                      if (mounted) setState(() {});
                                      checkCode();
                                    } else {
                                      customModal(
                                          context,
                                          Icon(
                                              CupertinoIcons
                                                  .exclamationmark_circle,
                                              size: 50,
                                              color: Colors.red),
                                          Text(
                                              "Please fill up the required field.",
                                              textAlign: TextAlign.center),
                                          true,
                                          Icon(
                                            CupertinoIcons.checkmark_alt,
                                            size: 25,
                                            color: Colors.greenAccent,
                                          ),
                                          'Okay',
                                          () {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool? checkEmptyRequiredField() {
    if (mobileController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool? checkEmptyRequiredFieldCode() {
    if (codeController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  check() async {
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      code = getRandomString(6);
      print(code);
      var chk = await checkCustomerMobileSendCode(context,
          mobileController.text.substring(1), mobileController.text, code);
      print(chk);
      List l = chk;
      if (l.length > 0) {
        connectionChecking = false;
        connectionChecingStatus = '';
        mobileVerified = true;
        if (mounted) setState(() {});
        Navigator.pop(context);

        GlobalVariables.forgotcustomerCode = l[0]['account_code'];
        GlobalVariables.forgotcustomerMobile = mobileController.text;
      } else {
        connectionChecking = false;
        connectionChecingStatus = '';
        mobileVerified = false;
        if (mounted) setState(() {});
        Navigator.pop(context);
        customModal(
            context,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.red),
            Text("Mobile Number not verified.", textAlign: TextAlign.center),
            true,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay',
            () {});
      }
    }
  }

  checkCode() async {
    if (code == codeController.text) {
    } else {
      connectionChecking = false;
      connectionChecingStatus = '';
      if (mounted) setState(() {});
      Navigator.pop(context);
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Code not verified.", textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          'Okay',
          () {});
    }
  }

  bool? checkMobile() {
    if (mobileController.text.length == 11 &&
        (getInitials(mobileController.text) == '0')) {
      print("truessss");
      return true;
    } else {
      return false;
    }
  }

  String getInitials(String mobile) => mobile.isNotEmpty
      ? mobile.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
}
