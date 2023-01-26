import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/widget/customModalCallSMS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Sessiontimer sessionTimer = Sessiontimer();
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
            title: Text("Contact Us",
                style: TextStyle(color: Colors.blueGrey[900])),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: GlobalVariables.contacts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(CupertinoIcons.person_alt,
                                                color: Colors.blueGrey[900]),
                                            Text(
                                              " ${GlobalVariables.contacts[index]['fullname'].toString().toUpperCase()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                                CupertinoIcons
                                                    .pencil_ellipsis_rectangle,
                                                color: Colors.blueGrey[900]),
                                            Text(
                                                " ${GlobalVariables.contacts[index]['position']} "),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            customModalCallSMS(
                                                context,
                                                Icon(
                                                    CupertinoIcons
                                                        .question_circle,
                                                    size: 50,
                                                    color: Colors.blue),
                                                Text(
                                                    "Call or Send SMS to ${GlobalVariables.contacts[index]['mobile']} ?",
                                                    textAlign:
                                                        TextAlign.center),
                                                Icon(
                                                  CupertinoIcons
                                                      .device_phone_portrait,
                                                  size: 25,
                                                  color: Colors.blue,
                                                ),
                                                'Call',
                                                () async {
                                                  Navigator.pop(context);
                                                  await launchUrl(Uri.parse(
                                                      "tel://${GlobalVariables.contacts[index]['mobile']}"));
                                                },
                                                Icon(
                                                  CupertinoIcons.envelope,
                                                  size: 25,
                                                  color: Colors.red,
                                                ),
                                                'SMS',
                                                () async {
                                                  Navigator.pop(context);
                                                  await launchUrl(Uri.parse(
                                                      "sms://${GlobalVariables.contacts[index]['mobile']}"));
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                  CupertinoIcons
                                                      .device_phone_portrait,
                                                  color: Colors.blueGrey[900]),
                                              Text(
                                                "${GlobalVariables.contacts[index]['mobile']}",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: brandingColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GlobalVariables.contacts[index]
                                                    ['telephone'] !=
                                                ''
                                            ? Row(
                                                children: [
                                                  Icon(CupertinoIcons.phone,
                                                      color:
                                                          Colors.blueGrey[900]),
                                                  Text(
                                                      " ${GlobalVariables.contacts[index]['telephone']}"),
                                                ],
                                              )
                                            : SizedBox(),
                                        GlobalVariables.contacts[index]
                                                    ['email'] !=
                                                ''
                                            ? Row(
                                                children: [
                                                  Icon(CupertinoIcons.envelope,
                                                      color:
                                                          Colors.blueGrey[900]),
                                                  InkWell(
                                                    onTap: () async {
                                                      final Uri params = Uri(
                                                        scheme: 'mailto',
                                                        path:
                                                            '${GlobalVariables.contacts[index]['email']}',
                                                      );
                                                      // String url =
                                                      //     params.toString();
                                                      // await launch(url);
                                                      Uri url = params;
                                                      await launchUrl(url);
                                                    },
                                                    child: Text(
                                                      "${GlobalVariables.contacts[index]['email']}",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: brandingColor),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
