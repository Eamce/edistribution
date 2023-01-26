import 'package:edistribution/services/api.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createNewMessageModal(BuildContext context) {
  print(GlobalVariables.customerServiceUsers);
  var size = MediaQuery.of(context).size;
  var _csrusers = GlobalVariables.customerServiceUsers;
  var _currentSelectedCSRName =
      GlobalVariables.customerServiceUsers[0]['name'].toString();
  var _currentSelectedCSRNameID =
      GlobalVariables.customerServiceUsers[0]['id'].toString();

  bool _sending = false;

  return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Customer Service",
                                style: TextStyle(
                                    color: Colors.blueGrey[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Icon(CupertinoIcons.person_alt,
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
                                      color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'Please select CSR',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              isEmpty: _currentSelectedCSRName == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedCSRName,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    _currentSelectedCSRName =
                                        newValue.toString();

                                    _csrusers.forEach((element) {
                                      if (element['name'].toString() ==
                                          _currentSelectedCSRName) {
                                        _currentSelectedCSRNameID =
                                            element['id'];
                                      }
                                    });

                                    modalState(() {});
                                  },
                                  items: _csrusers.map((users) {
                                    return DropdownMenuItem<String>(
                                      value: users['name'],
                                      child: Text(users['name']),
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
                            left: 20.0, right: 20.0, top: 15.0, bottom: 8.0),
                        child: MaterialButton(
                          minWidth: size.width,
                          color: brandingColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Create Conversation",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          onPressed: () async {
                            _sending = true;
                            modalState(() {});
                            await insertNewConvo(
                                context,
                                _currentSelectedCSRNameID,
                                _currentSelectedCSRName,
                                'Hello.');
                            _sending = false;
                            modalState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 3.0, bottom: 8.0),
                        child: MaterialButton(
                          minWidth: size.width,
                          color: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey[900],
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      _sending == true
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: LinearProgressIndicator(),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
