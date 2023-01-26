import 'dart:convert';
import 'package:edistribution/model/chatDetailModel.dart';
import 'package:edistribution/model/chatHeadModel.dart';
import 'package:edistribution/utility/enc_dec.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:http/http.dart' as http;

Future<List<ChatHead>> getChatHead(int offset) async {
  List<ChatHead> chatHeadList = [];
  var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getChatHead");
  final response = await http.post(url, headers: {
    "Accept": "Application/json"
  }, body: {
    'accountcode': encrypt(GlobalVariables.logcustomerCode),
    'offset': encrypt(offset.toString())
  });
  var convertedDataToJson = jsonDecode(decrypt(response.body));
  for (var chat in convertedDataToJson) {
    chatHeadList.add(ChatHead.fromJson(chat));
  }
  chatHeadList.sort((a, b) => b.newmsgdatetime.compareTo(a.newmsgdatetime));
  return chatHeadList;
}

Stream<List<ChatHead>> getChatHeads(Duration refreshTime, int offset) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await getChatHead(offset);
  }
}

Future<List<ChatDetail>> getChatHeadDetail(String refno) async {
  List<ChatDetail> chatDetailList = [];
  var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getChatHeadDetails");
  final response = await http.post(url, headers: {
    "Accept": "Application/json"
  }, body: {
    'refno': encrypt(refno),
  });
  var convertedDataToJson = jsonDecode(decrypt(response.body));
  for (var chat in convertedDataToJson) {
    chatDetailList.add(ChatDetail.fromJson(chat));
  }
  GlobalVariables.replyHolder = '';
  return chatDetailList;
}

Stream<List<ChatDetail>> getChatHeadDetails(
    Duration refreshTime, String refno) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await getChatHeadDetail(refno);
  }
}
