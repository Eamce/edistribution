class ChatHead {
  final String id;
  final String senderbackend;
  final String accountcode;
  final String refno;
  final String chatdatetime;
  final String status;
  final String chatnewmsg;
  final String sender;
  final String newmsgdatetime;
  final String msgstatbackend;
  final String msgstatsalesman;
  final String msgstatcustomer;

  ChatHead(
      {required this.id,
      required this.senderbackend,
      required this.accountcode,
      required this.refno,
      required this.chatdatetime,
      required this.status,
      required this.chatnewmsg,
      required this.sender,
      required this.newmsgdatetime,
      required this.msgstatbackend,
      required this.msgstatsalesman,
      required this.msgstatcustomer});

  factory ChatHead.fromJson(Map<String, dynamic> parsedJson) {
    return ChatHead(
      id: parsedJson['id'],
      senderbackend: parsedJson['sender_backend'],
      accountcode: parsedJson['account_code'],
      refno: parsedJson['ref_no'],
      chatdatetime: parsedJson['chat_datetime'],
      status: parsedJson['status'],
      chatnewmsg: parsedJson['lastmsg'][0]['msg_body'],
      sender: parsedJson['lastmsg'][0]['sender'],
      newmsgdatetime: parsedJson['lastmsg'][0]['msg_datetime'],
      msgstatbackend: parsedJson['lastmsg'][0]['status_backend'],
      msgstatsalesman: parsedJson['lastmsg'][0]['status_salesman'],
      msgstatcustomer: parsedJson['lastmsg'][0]['status_customer'],
    );
  }
}
