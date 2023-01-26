import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool? connectionChecking;
  String? connectionChecingStatus;
  final feedbackController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }

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
            title: Text("Send Feedback",
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Center(
                              child: Text(
                                "Send us your feedback!",
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
                            child: Center(
                              child: Text(
                                "How was your experience? Do you have a suggestion or found some bug? Let us know in the field below.",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12),
                                  color: Colors.blueGrey[900],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: 300,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: NotificationListener<
                                            OverscrollIndicatorNotification>(
                                          onNotification: (overscroll) {
                                            overscroll.disallowIndicator();
                                            return false;
                                          },
                                          child: Scrollbar(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              reverse: true,
                                              child: TextFormField(
                                                controller: feedbackController,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Feedback here...',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                if (checkEmptyRequiredField() == false) {
                                  submit();
                                } else {
                                  customModal(
                                      context,
                                      Icon(
                                          CupertinoIcons.exclamationmark_circle,
                                          size: 50,
                                          color: Colors.red),
                                      Text("No feedback to submit.",
                                          textAlign: TextAlign.center),
                                      true,
                                      Icon(
                                        CupertinoIcons.checkmark_alt,
                                        size: 25,
                                        color: Colors.greenAccent,
                                      ),
                                      '',
                                      () {});
                                }
                              },
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
    if (feedbackController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  submit() async {
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

    connectionChecking = true;
    connectionChecingStatus = 'Sending feedback';
    if (mounted) setState(() {});

    var con = await checkConnectedNetwork(context);
    if (con == 'OKAY') {
      await sendFeedback(context, feedbackController.text);
      Navigator.pop(context);
      connectionChecking = false;
      if (mounted) setState(() {});

      customModal(
          context,
          Icon(CupertinoIcons.checkmark_alt, size: 50, color: Colors.green),
          Text(
              "Thank you! By making your voice heard, you help us improve My NETgosyo.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});

      feedbackController.clear();
    }
  }
}
