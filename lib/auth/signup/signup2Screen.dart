import 'dart:io';

import 'package:edistribution/auth/signup/signup3Screen.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/images.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class Signup2Screen extends StatefulWidget {
  const Signup2Screen({Key? key}) : super(key: key);

  @override
  _Signup2ScreenState createState() => _Signup2ScreenState();
}

class _Signup2ScreenState extends State<Signup2Screen> {
  File? _storeImage;
  String? _storePath;
  File? _bcImage;
  String? _bcPath;
  final picker = ImagePicker();

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
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Tap on image to start taking photo.",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Store Photo",
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
                            child: InkWell(
                              child: Container(
                                height: size.height / 3,
                                width: size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _storeImage == null
                                        ? AssetImage(Images.camera)
                                            as ImageProvider
                                        : FileImage(_storeImage!),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              onTap: () {
                                getStoreImage();
                              },
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Barangay Clearance Photo",
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
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 20.0),
                            child: InkWell(
                              child: Container(
                                height: size.height / 3,
                                width: size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _bcImage == null
                                        ? AssetImage(Images.camera)
                                            as ImageProvider
                                        : FileImage(_bcImage!),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              onTap: () {
                                getBCImage();
                              },
                            ),
                          ),
                        ],
                      ),
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
                          "Next",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        if (checkEmptyRequiredPhoto() == false) {
                          goToRegistration();
                        } else {
                          customModal(
                              context,
                              Icon(CupertinoIcons.exclamationmark_circle,
                                  size: 50, color: Colors.red),
                              Text(
                                  "Store and Barangay Clearance Photo are required.",
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
          ),
        ),
      ),
    );
  }

  Future getStoreImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 450.0, maxWidth: 450.0);

    if (mounted)
      setState(() {
        if (pickedFile != null) {
          _storeImage = File(pickedFile.path);
          _storePath = pickedFile.path;
          print(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
  }

  Future getBCImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 450.0, maxWidth: 450.0);

    if (mounted)
      setState(() {
        if (pickedFile != null) {
          _bcImage = File(pickedFile.path);
          _bcPath = pickedFile.path;
          print(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
  }

  bool? checkEmptyRequiredPhoto() {
    if (_storeImage == null || _bcImage == null) {
      return true;
    } else {
      return false;
    }
  }

  goToRegistration() {
    GlobalVariables.holderStorePhotoPath = _storePath!;
    GlobalVariables.holderBCPhotoPath = _bcPath!;

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: Signup3Screen()));
  }
}
