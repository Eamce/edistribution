import 'package:edistribution/menu.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/cartCountTimer.dart';
import 'package:edistribution/utility/chatCountTimer.dart';
import 'package:edistribution/utility/concurrentLoginTimer.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customLogicalModal.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordExpiredChange extends StatefulWidget {
  const PasswordExpiredChange({Key? key}) : super(key: key);

  @override
  _PasswordExpiredChangeState createState() => _PasswordExpiredChangeState();
}

class _PasswordExpiredChangeState extends State<PasswordExpiredChange> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  final newPassController = TextEditingController();
  final newConfirmPassController = TextEditingController();

  bool? showNewPassword;
  bool? showNewConfirmPassword;

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;

  @override
  void initState() {
    showNewPassword = true;
    showNewConfirmPassword = true;
    super.initState();
  }

  Sessiontimer sessionTimer = Sessiontimer();
  CartCountTimer cartCountTimer = CartCountTimer();
  Concurrentlogintimer concurrentlogintimer = Concurrentlogintimer();
  ChatCountTimer chatCountTimer = ChatCountTimer();
  void handleUserInteraction([_]) {
    sessionTimer.initializeTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "New Password",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Required",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(
                              controller: newPassController,
                              obscureText: showNewPassword!,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                color: Colors.blueGrey[900],
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: newPassController.text.isNotEmpty
                                          ? Icon(
                                              CupertinoIcons.xmark_circle_fill,
                                              color: Colors.redAccent)
                                          : SizedBox(),
                                      onPressed: () {
                                        newPassController.clear();
                                        hasMinLength = false;
                                        hasUppercase = false;
                                        hasLowercase = false;
                                        hasDigits = false;
                                        hasSpecialCharacters = false;
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: !showNewPassword!
                                          ? Icon(CupertinoIcons.eye_fill,
                                              color: Colors.blueGrey[900])
                                          : Icon(CupertinoIcons.eye_slash_fill,
                                              color: Colors.blueGrey[900]),
                                      onPressed: () {
                                        showNewPassword = !showNewPassword!;
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter new password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onChanged: (value) {
                                hasMinLength = value.length > 7;
                                hasUppercase =
                                    value.contains(new RegExp(r'[A-Z]'));
                                hasLowercase =
                                    value.contains(new RegExp(r'[a-z]'));
                                hasDigits =
                                    value.contains(new RegExp(r'[0-9]'));
                                hasSpecialCharacters = value.contains(
                                    new RegExp(r'[!@#$%^&*(),.?":{}|<>\-\_]'));
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Confirm Password",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Required",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(
                              controller: newConfirmPassController,
                              obscureText: showNewConfirmPassword!,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                color: Colors.blueGrey[900],
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: newConfirmPassController
                                              .text.isNotEmpty
                                          ? Icon(
                                              CupertinoIcons.xmark_circle_fill,
                                              color: Colors.redAccent)
                                          : SizedBox(),
                                      onPressed: () {
                                        newConfirmPassController.clear();
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: !showNewConfirmPassword!
                                          ? Icon(CupertinoIcons.eye_fill,
                                              color: Colors.blueGrey[900])
                                          : Icon(CupertinoIcons.eye_slash_fill,
                                              color: Colors.blueGrey[900]),
                                      onPressed: () {
                                        showNewConfirmPassword =
                                            !showNewConfirmPassword!;
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter confirm password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onChanged: (value) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 20.0, top: 8.0),
                            child: MaterialButton(
                              minWidth: size.width,
                              color: brandingColor,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                if (checkEmptyRequiredField() == false) {
                                  if (isPasswordCompliant() == false) {
                                    if (checkIfEqual() == true) {
                                      //save
                                      connectionChecking = true;
                                      connectionChecingStatus =
                                          'Saving password';
                                      if (mounted) setState(() {});

                                      var con =
                                          await checkConnectedNetwork(context);
                                      if (con == 'OKAY') {
                                        var res = await changePass(
                                            context,
                                            GlobalVariables.logcustomerCode,
                                            newPassController.text);
                                        if (res != "passwordused" &&
                                            res != null) {
                                          connectionChecking = false;
                                          connectionChecingStatus = '';
                                          if (mounted) setState(() {});
                                          customLogicalModal(
                                              context,
                                              Text(
                                                  'Password successfully changed. Logout?'),
                                              () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }, () {
                                            newPassController.clear();
                                            newConfirmPassController.clear();
                                            Navigator.pop(context);
                                            //logout
                                            // imageCache!.clear();
                                            // imageCache!.clearLiveImages();
                                            sessionTimer.cancelSessiontimer();
                                            cartCountTimer.cancelCartCount();
                                            chatCountTimer.cancelChatCount();
                                            concurrentlogintimer
                                                .cancelCheckingconcurrentlog();
                                            GlobalVariables.logcustomerCode =
                                                '';
                                            GlobalVariables.menuCurrentIndex =
                                                0;
                                            GlobalVariables.cartItemCount = 0;

                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Menu(),
                                              ),
                                              (Route route) =>
                                                  false, //if you want to disable back feature set to false1
                                            );
                                          });
                                        } else if (res == "passwordused") {
                                          connectionChecking = false;
                                          connectionChecingStatus = '';
                                          if (mounted) setState(() {});
                                          customModal(
                                              context,
                                              Icon(
                                                  CupertinoIcons
                                                      .exclamationmark_circle,
                                                  size: 50,
                                                  color: Colors.red),
                                              Text(
                                                  "You already used this password. Try a different one.",
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
                                          connectionChecking = false;
                                          connectionChecingStatus = '';
                                          if (mounted) setState(() {});
                                        }
                                      }
                                    } else {
                                      customModal(
                                          context,
                                          Icon(
                                              CupertinoIcons
                                                  .exclamationmark_circle,
                                              size: 50,
                                              color: Colors.red),
                                          Text("Password do not match.",
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
                                            "The password does not meet the password policy requirements.",
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
                                          CupertinoIcons.exclamationmark_circle,
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
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Password must:",
                              style: TextStyle(color: Colors.blueGrey[900]),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              " * Have a minimum of 8 characters",
                              style: TextStyle(
                                color: hasMinLength
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              " * Include atleast 1 uppercase",
                              style: TextStyle(
                                color: hasUppercase
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              " * Include atleast 1 lowercase",
                              style: TextStyle(
                                color: hasLowercase
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              " * Include atleast 1 digit",
                              style: TextStyle(
                                color:
                                    hasDigits ? Colors.green : Colors.redAccent,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 20.0),
                            child: Text(
                              ' * Include atleast 1 special character: !@#\$%^&*(),.?":{}|<>-_',
                              style: TextStyle(
                                color: hasSpecialCharacters
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
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

  bool? checkEmptyRequiredField() {
    if (newPassController.text.isEmpty ||
        newConfirmPassController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool? checkIfEqual() {
    if (newPassController.text == newConfirmPassController.text) {
      return true;
    } else {
      return false;
    }
  }

  bool? isPasswordCompliant() {
    if (hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength) {
      return false;
    } else {
      return true;
    }
  }
}
