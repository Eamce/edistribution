import 'dart:math';

import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup3Screen extends StatefulWidget {
  const Signup3Screen({Key? key}) : super(key: key);

  @override
  _Signup3ScreenState createState() => _Signup3ScreenState();
}

class _Signup3ScreenState extends State<Signup3Screen> {
  bool? creatingDone;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String _tempPassword = '';

  String _photoName = '';

  @override
  void initState() {
    super.initState();
    _tempPassword = getRandomString(8);
    creatingDone = false;

    submit();
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
          automaticallyImplyLeading: false,
          title: Text("Create Account",
              style: TextStyle(color: Colors.blueGrey[900])),
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
                  Container(
                    width: size.width,
                    height: size.height - appBarSize * 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        creatingDone == false
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(),
                              )
                            : SizedBox(),
                        creatingDone == false
                            ? Text("Submitting Registration...",
                                style: TextStyle(color: Colors.blueGrey[900]))
                            : SizedBox(),
                        creatingDone == true
                            ? Column(
                                children: [
                                  Center(
                                      child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 100,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Your registration was submitted and ready to evaluate. Just wait for the SMS confirmation. Thank you."),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Container(
                                        width: size.width / 3,
                                        height: size.height / 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Spacer(),
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              size: 25,
                                              color: Colors.greenAccent,
                                            ),
                                            Text('Okay'),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                      ],
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

  submit() async {
    _photoName =
        "${GlobalVariables.ownerName.replaceAll(new RegExp(r"\s+"), "")}_${GlobalVariables.mobile.replaceAll(new RegExp(r"\s+"), "")}_${GlobalVariables.storeName.replaceAll(new RegExp(r"\s+"), "")}.jpg";
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      await register(context, _tempPassword, _photoName);
      await uploadStorePhoto();
      await uploadBCPhoto();
      creatingDone = true;
      if (mounted) setState(() {});
    } else {
      creatingDone = true;
      if (mounted) setState(() {});
    }
  }

  uploadStorePhoto() async {
    await uploadPhoto(context, 'store_img',
        GlobalVariables.holderStorePhotoPath.toString(), _photoName);
  }

  uploadBCPhoto() async {
    await uploadPhoto(context, 'bc_img',
        GlobalVariables.holderBCPhotoPath.toString(), _photoName);
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
