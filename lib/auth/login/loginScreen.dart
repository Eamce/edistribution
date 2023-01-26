import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:edistribution/account/changePassword.dart';
import 'package:edistribution/auth/forgot/numberVerify.dart';
import 'package:edistribution/auth/login/passwordExpiredChange.dart';
import 'package:edistribution/privacy/dataPrivacy.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/cartCountTimer.dart';
import 'package:edistribution/utility/chatCountTimer.dart';
import 'package:edistribution/utility/concurrentLoginTimer.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/images.dart';
import 'package:edistribution/widget/customLogicalModal.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? connectionChecking;
  String? connectionChecingStatus;
  bool? showPassword;
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  String mobileInvalidPassword = "";
  int invalidAttempt = 0;
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  CartCountTimer cartCountTimer = CartCountTimer();
  Sessiontimer sessiontimer = Sessiontimer();
  Concurrentlogintimer concurrentlogintimer = Concurrentlogintimer();
  ChatCountTimer chatCountTimer = ChatCountTimer();

  @override
  void initState() {
    showPassword = true;
    _deviceDetails();
    _getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
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
          title: Text("Welcome Back",
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
          child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      height: size.height - appBarSize * 2,
                      decoration: BoxDecoration(
                          color: brandingColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                Images.logo,
                                width: size.height / 5,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width,
                            // height: (size.height - appBarSize * 2) / 1.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20.0, right: 20.0),
                                  child: Text(
                                    "Mobile",
                                    style:
                                        TextStyle(color: Colors.blueGrey[900]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                    ],
                                    maxLength: 11,
                                    controller: mobileController,
                                    keyboardType: TextInputType.number,
                                    style:
                                        TextStyle(color: Colors.blueGrey[900]),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Icon(
                                            CupertinoIcons
                                                .device_phone_portrait,
                                            color: Colors.blueGrey[900]),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: mobileController.text.isNotEmpty
                                            ? Icon(
                                                CupertinoIcons
                                                    .xmark_circle_fill,
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
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20.0, right: 20.0),
                                  child: Text(
                                    "Password",
                                    style:
                                        TextStyle(color: Colors.blueGrey[900]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: showPassword!,
                                    style:
                                        TextStyle(color: Colors.blueGrey[900]),
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Icon(CupertinoIcons.lock_circle,
                                            color: Colors.blueGrey[900]),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: passwordController
                                                    .text.isNotEmpty
                                                ? Icon(
                                                    CupertinoIcons
                                                        .xmark_circle_fill,
                                                    color: Colors.redAccent)
                                                : SizedBox(),
                                            onPressed: () {
                                              passwordController.clear();
                                              if (mounted) setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: !showPassword!
                                                ? Icon(CupertinoIcons.eye_fill,
                                                    color: Colors.blueGrey[900])
                                                : Icon(
                                                    CupertinoIcons
                                                        .eye_slash_fill,
                                                    color:
                                                        Colors.blueGrey[900]),
                                            onPressed: () {
                                              showPassword = !showPassword!;
                                              if (mounted) setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black54),
                                      hintText: "Enter Password",
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
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.transparent)),
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: NumberVerify()));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: MaterialButton(
                                    minWidth: size.width,
                                    color: brandingColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
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
                                              'Checking credentials';
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
                                                "Please fill up the required fields.",
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Row(
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.transparent)),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "Learn about ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Data Privacy",
                                              style: TextStyle(
                                                color: brandingColor,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: DataPrivacy(
                                                    useFor: "VIEW",
                                                  )));
                                        },
                                      ),
                                      Spacer(),
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.transparent)),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "Signup",
                                              style: TextStyle(
                                                color: brandingColor,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: DataPrivacy(
                                                    useFor: "SIGNUP",
                                                  )));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        identifier = build.androidId;

        GlobalVariables.deviceInfo = "$deviceName $identifier";
        GlobalVariables.readdeviceInfo = "${build.brand} ${build.device}";

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;

        deviceName = data.name;
        identifier = data.identifierForVendor;
        GlobalVariables.deviceInfo = "$deviceName $identifier";
        GlobalVariables.readdeviceInfo = "${data.utsname.machine}";
        //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  _getAppVersion() async {
    try {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        GlobalVariables.appVersion = packageInfo.version;
      });
    } on PlatformException {
      GlobalVariables.appVersion = "";
    }
  }

  bool? checkEmptyRequiredField() {
    if (mobileController.text.isEmpty || passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  check() async {
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      var res = await customerLogin(
          context, mobileController.text.substring(1), passwordController.text);
      print(res);
      if (res != 'invaliduser' && res != 'invalidpassword') {
        logMe(res);
      } else if (res == 'invaliduser') {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);
        customModal(
            context,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.red),
            Text("Invalid credentials.", textAlign: TextAlign.center),
            true,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay',
            () {});
      } else if (res == 'invalidpassword') {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);
        if (mobileInvalidPassword == mobileController.text) {
          mobileInvalidPassword = mobileController.text;
          invalidAttempt = invalidAttempt + 1;
        } else {
          mobileInvalidPassword = mobileController.text;
          invalidAttempt = 0;
        }
        if (invalidAttempt >= 3) {
          await updateAccountLocked(
              context, mobileController.text.substring(1), '1');
          customModal(
              context,
              Icon(CupertinoIcons.exclamationmark_circle,
                  size: 50, color: Colors.red),
              Text(
                  "Your account has been locked due to multiple invalid login attempts. Unlock it by changing your password using the Forgot Password.",
                  textAlign: TextAlign.center),
              true,
              Icon(
                CupertinoIcons.checkmark_alt,
                size: 25,
                color: Colors.greenAccent,
              ),
              'Okay',
              () {});
        } else {
          customModal(
              context,
              Icon(CupertinoIcons.exclamationmark_circle,
                  size: 50, color: Colors.red),
              Text("Invalid credentials.", textAlign: TextAlign.center),
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
  }

  logMe(List details) async {
    if (details[0]['isBlock'] == '0') {
      final difference = DateTime.now()
          .difference(DateTime.parse(details[0]['password_date']))
          .inDays;
      if (difference <= 90) {
        await updateActiveDevice(context, details[0]['account_code'],
            GlobalVariables.deviceInfo, GlobalVariables.readdeviceInfo);
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);
        GlobalVariables.logcustomerCode = details[0]['account_code'];
        GlobalVariables.logcustomerName = details[0]['account_name'];
        GlobalVariables.logcustomerAddress =
            "${details[0]['address_landmark']}, ${details[0]['address_street']}, ${details[0]['address_barangay']}, ${details[0]['address3']}, ${details[0]['address1']}";
        GlobalVariables.logcustomerSM = details[0]['salesman_code'];
        GlobalVariables.logcustomerAppRate = int.parse(details[0]['appRate']);
        details[0]['first_log'] == 'done'
            ? GlobalVariables.logcustomerFirstLogDone = true
            : GlobalVariables.logcustomerFirstLogDone = false;
        details[0]['applyCreditLimit'] == '1'
            ? GlobalVariables.logcustomerApplyCreditLimit = true
            : GlobalVariables.logcustomerApplyCreditLimit = false;
        if (GlobalVariables.logcustomerApplyCreditLimit == true) {
          GlobalVariables.logcustomerCreditLimit =
              double.parse(details[0]['account_credit_limit']);
          GlobalVariables.logcustomerCurrentCredit =
              double.parse(details[0]['account_credit_current']);
        }
        Navigator.pop(context);
        if (!GlobalVariables.logcustomerFirstLogDone)
          customModal(
              GlobalVariables.homescreenContext!,
              Icon(CupertinoIcons.lock_shield, size: 50, color: Colors.green),
              Text(
                  "Welcome, First time logging in? To continue using the app please change your default password.",
                  textAlign: TextAlign.center),
              false,
              Icon(
                CupertinoIcons.lock_rotation,
                size: 25,
                color: Colors.greenAccent,
              ),
              'Change now', () {
            Navigator.pop(GlobalVariables.menuContext!);
            Navigator.push(
                GlobalVariables.menuContext!,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ChangePassword()));
          });

        cartCountTimer.initializeTimer(context);
        sessiontimer.initializeTimer(context);
        concurrentlogintimer.initializeTimer(context);
        chatCountTimer.initializeTimer(context);
      } else {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);

        customLogicalModal(
            context,
            Text(
                'Your password has expired. Change your password to continue using the app. Continue?'),
            () {
          Navigator.pop(context);
          GlobalVariables.logcustomerCode = '';
        }, () {
          GlobalVariables.logcustomerCode = details[0]['account_code'];
          GlobalVariables.logcustomerName = details[0]['account_name'];
          GlobalVariables.logcustomerAddress =
              "${details[0]['address_landmark']}, ${details[0]['address_street']}, ${details[0]['address_barangay']}, ${details[0]['address3']}, ${details[0]['address1']}";
          GlobalVariables.logcustomerSM = details[0]['salesman_code'];
          GlobalVariables.logcustomerAppRate = int.parse(details[0]['appRate']);
          details[0]['first_log'] == 'done'
              ? GlobalVariables.logcustomerFirstLogDone = true
              : GlobalVariables.logcustomerFirstLogDone = false;
          details[0]['applyCreditLimit'] == '1'
              ? GlobalVariables.logcustomerApplyCreditLimit = true
              : GlobalVariables.logcustomerApplyCreditLimit = false;
          if (GlobalVariables.logcustomerApplyCreditLimit == true) {
            GlobalVariables.logcustomerCreditLimit =
                double.parse(details[0]['account_credit_limit']);
            GlobalVariables.logcustomerCurrentCredit =
                double.parse(details[0]['account_credit_current']);
          }

          cartCountTimer.initializeTimer(context);
          sessiontimer.initializeTimer(context);
          chatCountTimer.initializeTimer(context);

          mobileController.clear();
          passwordController.clear();
          Navigator.pop(context);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: PasswordExpiredChange()));
        });
      }
    } else {
      connectionChecking = false;
      connectionChecingStatus = '';
      if (mounted) setState(() {});
      Navigator.pop(context);

      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Your account has been locked due to multiple invalid login attempts. Unlock it by changing your password using the Forgot Password.",
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
