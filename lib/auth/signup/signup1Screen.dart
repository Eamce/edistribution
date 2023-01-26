import 'package:edistribution/auth/signup/signup2Screen.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class Singup1Screen extends StatefulWidget {
  const Singup1Screen({Key? key}) : super(key: key);

  @override
  _Singup1ScreenState createState() => _Singup1ScreenState();
}

class _Singup1ScreenState extends State<Singup1Screen> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  final ownerNameController = TextEditingController();
  final mobileController = TextEditingController();
  final telephoneController = TextEditingController();
  final addresslineController = TextEditingController();
  final landmarkController = TextEditingController();
  final storeNameController = TextEditingController();
  final dtiController = TextEditingController();
  var _towns = GlobalVariables.towns;
  var _currentSelectedTownValue = "Alburquerque";
  var _currentSelectedTownValueID = '1';
  var _barangays = GlobalVariables.barangays;
  var _currentSelectedBarangayID = '1';
  var _filteredBarangays = [];
  var _currentSelectedBarangayValue;

  @override
  void initState() {
    super.initState();
    filterBarangays();
  }

  @override
  void dispose() {
    super.dispose();
    ownerNameController.dispose();
    mobileController.dispose();
    telephoneController.dispose();
    addresslineController.dispose();
    landmarkController.dispose();
    storeNameController.dispose();
    dtiController.dispose();
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
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
          title: Text("Create Account",
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
                                    text: "Owner Name",
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
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z'-. Ññ]"))
                              ],
                              controller: ownerNameController,
                              style: TextStyle(color: Colors.blueGrey[900]),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(CupertinoIcons.person_alt_circle,
                                      color: Colors.blueGrey[900]),
                                ),
                                suffixIcon: IconButton(
                                  icon: ownerNameController.text.isNotEmpty
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                      : SizedBox(),
                                  onPressed: () {
                                    ownerNameController.clear();
                                    if (mounted) setState(() {});
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter Owner Name",
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
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Mobile",
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
                                const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
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
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Telephone",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Optional",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              controller: telephoneController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.blueGrey[900]),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(CupertinoIcons.phone,
                                      color: Colors.blueGrey[900]),
                                ),
                                suffixIcon: IconButton(
                                  icon: telephoneController.text.isNotEmpty
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                      : SizedBox(),
                                  onPressed: () {
                                    telephoneController.clear();
                                    if (mounted) setState(() {});
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter Telephone",
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
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Sitio/Purok/Street",
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
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              controller: addresslineController,
                              style: TextStyle(color: Colors.blueGrey[900]),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(CupertinoIcons.house_alt,
                                      color: Colors.blueGrey[900]),
                                ),
                                suffixIcon: IconButton(
                                  icon: addresslineController.text.isNotEmpty
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                      : SizedBox(),
                                  onPressed: () {
                                    addresslineController.clear();
                                    if (mounted) setState(() {});
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter Sitio/Purok/Street",
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
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Landmark",
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
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              controller: landmarkController,
                              style: TextStyle(color: Colors.blueGrey[900]),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(CupertinoIcons.house_alt,
                                      color: Colors.blueGrey[900]),
                                ),
                                suffixIcon: IconButton(
                                  icon: landmarkController.text.isNotEmpty
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                      : SizedBox(),
                                  onPressed: () {
                                    landmarkController.clear();
                                    if (mounted) setState(() {});
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter Landmark",
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
                                top: 20.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Town",
                              style: TextStyle(color: Colors.blueGrey[900]),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Icon(CupertinoIcons.house_alt,
                                            color: Colors.blueGrey[900]),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                      ),
                                      errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      hintText: 'Please select town',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  isEmpty: _currentSelectedTownValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _currentSelectedTownValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        _currentSelectedTownValue =
                                            newValue.toString();

                                        _towns.forEach((element) {
                                          if (element['town_name'].toString() ==
                                              _currentSelectedTownValue) {
                                            _currentSelectedTownValueID =
                                                element['town_id'];
                                          }
                                        });

                                        filterBarangays();
                                        state.didChange(newValue);
                                        if (mounted) setState(() {});
                                      },
                                      items: _towns.map((town) {
                                        return DropdownMenuItem<String>(
                                          value: town['town_name'],
                                          child: Text(town['town_name']),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Barangay",
                              style: TextStyle(color: Colors.blueGrey[900]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 20.0),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Icon(CupertinoIcons.house_alt,
                                            color: Colors.blueGrey[900]),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                      ),
                                      errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      hintText: 'Please select barangay',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  isEmpty: _currentSelectedBarangayValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _currentSelectedBarangayValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        if (mounted)
                                          setState(() {
                                            _currentSelectedBarangayValue =
                                                newValue.toString();

                                            _barangays.forEach((element) {
                                              if (element['brgy_name']
                                                      .toString() ==
                                                  _currentSelectedBarangayValue) {
                                                _currentSelectedBarangayID =
                                                    element['brgy_id'];
                                              }
                                            });

                                            state.didChange(newValue);
                                          });
                                      },
                                      items: _filteredBarangays.map((barangay) {
                                        return DropdownMenuItem<String>(
                                          value: barangay['b_name'],
                                          child: Text(barangay['b_name']),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                    text: "Store Name",
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
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z'-. Ññ]"))
                              ],
                              controller: storeNameController,
                              style: TextStyle(color: Colors.blueGrey[900]),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(CupertinoIcons.tray,
                                      color: Colors.blueGrey[900]),
                                ),
                                suffixIcon: IconButton(
                                  icon: storeNameController.text.isNotEmpty
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                      : SizedBox(),
                                  onPressed: () {
                                    storeNameController.clear();
                                    if (mounted) setState(() {});
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter Store Name",
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
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "DTI Certificate Number",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Optional",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 20.0),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              controller: dtiController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.blueGrey[900]),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(CupertinoIcons.checkmark_seal,
                                      color: Colors.blueGrey[900]),
                                ),
                                suffixIcon: IconButton(
                                  icon: dtiController.text.isNotEmpty
                                      ? Icon(CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                      : SizedBox(),
                                  onPressed: () {
                                    dtiController.clear();
                                    if (mounted) setState(() {});
                                  },
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter DTI Certificate Number",
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
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 20.0),
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
                        if (checkEmptyRequiredField() == false) {
                          if (checkMobile() == true) {
                            showDialog<String>(
                              barrierDismissible: false,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) => WillPopScope(
                                onWillPop: () async => false,
                                child: AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                ),
                              ),
                            );
                            goNext();
                          } else {
                            customModal(
                                context,
                                Icon(CupertinoIcons.exclamationmark_circle,
                                    size: 50, color: Colors.red),
                                Text("Mobile Number format is not valid.",
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
                              Icon(CupertinoIcons.exclamationmark_circle,
                                  size: 50, color: Colors.red),
                              Text("Please fill up the required fields.",
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

  filterBarangays() {
    var _holder = [];
    _barangays.forEach((element) {
      if (element['town_id'] == _currentSelectedTownValueID) {
        _holder.add({'b_name': element['brgy_name']});
      }
    });
    _currentSelectedBarangayValue = _holder[0]['b_name'];
    _barangays.forEach((element) {
      if (element['brgy_name'] == _currentSelectedBarangayValue &&
          element['town_id'] == _currentSelectedTownValueID) {
        _currentSelectedBarangayID = element['brgy_id'];
      }
    });

    _filteredBarangays = _holder;
    print(_filteredBarangays);
    if (mounted) setState(() {});
  }

  bool? checkEmptyRequiredField() {
    if (ownerNameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        addresslineController.text.isEmpty ||
        landmarkController.text.isEmpty ||
        storeNameController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool? checkMobile() {
    if (mobileController.text.length == 11 &&
        (getInitials(mobileController.text) == '0')) {
      return true;
    } else {
      return false;
    }
  }

  String getInitials(String mobile) => mobile.isNotEmpty
      ? mobile.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  goNext() async {
    connectionChecking = true;
    connectionChecingStatus = 'Verifying';
    if (mounted) setState(() {});
    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      var chk =
          await checkMobileSignup(context, mobileController.text.substring(1));
      if (chk == 'notused') {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);

        GlobalVariables.ownerName = ownerNameController.text;
        GlobalVariables.mobile = mobileController.text.substring(1);
        if (telephoneController.text.isNotEmpty)
          GlobalVariables.telephone = telephoneController.text;
        GlobalVariables.sitio = addresslineController.text;
        GlobalVariables.landmark = landmarkController.text;
        GlobalVariables.stown = _currentSelectedTownValue;
        GlobalVariables.stownCode = _currentSelectedTownValueID;
        GlobalVariables.sbarangay = _currentSelectedBarangayValue;
        GlobalVariables.sbarangayCode = _currentSelectedBarangayID;
        GlobalVariables.storeName = storeNameController.text;
        if (dtiController.text.isNotEmpty)
          GlobalVariables.dti = dtiController.text;

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: Signup2Screen()));
      } else if (chk == 'masterfile') {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);
        customModal(
            context,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.red),
            Text("Mobile number already registered to someone.",
                textAlign: TextAlign.center),
            true,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay',
            () {});
      } else if (chk == 'request') {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        Navigator.pop(context);
        customModal(
            context,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.red),
            Text("Mobile number used in registration but still pending.",
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
      connectionChecking = false;
      connectionChecingStatus = '';
      if (mounted) setState(() {});
      Navigator.pop(context);
    }
  }
}
