import 'package:edistribution/values/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

customUpdateModal(BuildContext context, Uri apkLink) {
  var size = MediaQuery.of(context).size;
  return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(CupertinoIcons.info_circle,
                          size: 50, color: Colors.blueAccent),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                          "The new version(${GlobalVariables.trigVarUPDTE}) of My NETgosyo is available. Get the latest version to optimize the compatibility of the app. \n\nWhat's new: ${GlobalVariables.updteChangeLog}."),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "\nNote: For old mobile phones, better to uninstall first the existing app before installing the updated version to prevent error while installing.",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Container(
                              width: size.width / 3,
                              height: size.height / 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Spacer(),
                                  Icon(
                                    CupertinoIcons.arrow_uturn_down_circle,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                  Text("Update"),
                                  Spacer(),
                                ],
                              ),
                            ),
                            onTap: () async {
                              // launch(apkLink);
                              // if (await canLaunch(apkLink)) {
                              //   await launch(apkLink);
                              // } else {
                              //   throw 'Could not launch $apkLink';
                              // }
                              // if (!await launchUrl(Uri.parse(apkLink)))
                              //   throw 'Could not launch $apkLink';
                              if (!await launchUrl(
                                apkLink,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw 'Could not launch $apkLink';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
