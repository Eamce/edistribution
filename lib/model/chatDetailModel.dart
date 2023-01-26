class ChatDetail {
  final String id;
  final String refno;
  final String msgbody;
  final String sender;
  final String msgdatetime;
  final String statusbackend;
  final String statuscustomer;
  final String headStatus;

  ChatDetail({
    required this.id,
    required this.refno,
    required this.msgbody,
    required this.sender,
    required this.msgdatetime,
    required this.statusbackend,
    required this.statuscustomer,
    required this.headStatus,
  });

  factory ChatDetail.fromJson(Map<String, dynamic> parsedJson) {
    return ChatDetail(
      id: parsedJson['id'],
      refno: parsedJson['ref_no'],
      msgbody: parsedJson['msg_body'],
      sender: parsedJson['sender'],
      msgdatetime: parsedJson['msg_datetime'],
      statusbackend: parsedJson['status_backend'],
      statuscustomer: parsedJson['status_customer'],
      headStatus: parsedJson['status'],
    );
  }
}
