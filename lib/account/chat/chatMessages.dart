import 'package:edistribution/account/chat/chatMessagesDetail.dart';
import 'package:edistribution/services/apichat.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/widget/createNewMessageModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatMessages extends StatefulWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
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
            title:
                Text("Messages", style: TextStyle(color: Colors.blueGrey[900])),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: brandingColor,
            onPressed: () {
              createNewMessageModal(context);
            },
          ),
          body: Center(
            child: StreamBuilder<List>(
              stream: getChatHeads(Duration(seconds: 1), 0),
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.done) {
                  return Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  );
                }
                if (stream.hasData) {
                  return Scrollbar(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: ListView(
                        children: List.generate(
                          stream.data!.length,
                          (index) {
                            // if (stream.data![index].msgstatcustomer ==
                            //         'unseen' &&
                            //     stream.data![index].sender != 'customer') {
                            //   var sender =
                            //       'New message from ${stream.data![index].sender.toString().toUpperCase()}';
                            //   var msg =
                            //       'Message: ${stream.data![index].chatnewmsg}';
                            //   NotificationService notificationService =
                            //       NotificationService();
                            //   notificationService.initialize();
                            //   notificationService.instantNotification(
                            //       int.parse(stream.data![index].id),
                            //       sender,
                            //       msg);
                            // }
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          stream.data![index].status == 'active'
                                              ? CupertinoIcons.text_bubble_fill
                                              : CupertinoIcons.text_bubble,
                                          size: size.width / 8,
                                          color: stream.data![index].status ==
                                                  'active'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 8.0),
                                                  child: stream.data![index]
                                                              .status ==
                                                          'active'
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .lock_open_fill,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          CupertinoIcons
                                                              .lock_fill,
                                                          color: Colors.red,
                                                        ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0, top: 8.0),
                                                  child: Text(
                                                      "${stream.data![index].senderbackend}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0,
                                                          top: 8.0),
                                                  child: Text(
                                                      "${timeago.format(DateTime.parse(stream.data![index].newmsgdatetime))}",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight: stream
                                                                      .data![
                                                                          index]
                                                                      .msgstatcustomer ==
                                                                  'unseen'
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal,
                                                          color: stream
                                                                      .data![
                                                                          index]
                                                                      .status ==
                                                                  'active'
                                                              ? Colors.black
                                                              : Colors.grey)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                  "Ref#: ${stream.data![index].refno}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  bottom: 8.0),
                                              child: Text(
                                                stream.data![index].sender ==
                                                        'customer'
                                                    ? "You: ${stream.data![index].chatnewmsg}"
                                                    : "${stream.data![index].chatnewmsg}",
                                                style: TextStyle(
                                                    fontWeight: stream
                                                                .data![index]
                                                                .msgstatcustomer ==
                                                            'unseen'
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    color: stream.data![index]
                                                                .status ==
                                                            'active'
                                                        ? Colors.black
                                                        : Colors.grey),
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: ChatMessagesDetail(
                                          sender:
                                              stream.data![index].senderbackend,
                                          refno: stream.data![index].refno,
                                          active: stream.data![index].status,
                                        )));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
