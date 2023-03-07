import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:edistribution/utility/enc_dec.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future checkConnection(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/checkConnection");
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {}).timeout(const Duration(seconds: 20));
    if (response.statusCode == 200) {
      return "OKAY";
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future checkTrigVar(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/checkTrigVariables");
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {}).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getCutOffTime(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getCutOffTime");
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {}).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getCategories(BuildContext context, int limit) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getPrincipals");
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {'limit': encrypt(limit.toString())});
    print(response.statusCode);
    if (response.statusCode == 200) {
      // var convertedDataToJson = jsonDecode(decrypt(response.body));
      var convertedDataToJson = jsonDecode(response.body);
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getProducts(BuildContext context, String name, int limit) async {
  print('VENDOR CODE: $name');
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getProducts_test");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode.isNotEmpty
          ? GlobalVariables.logcustomerCode
          : 'null'),
      // 'category': encrypt(name),
      'vendor_code': encrypt(name),
      'limit': encrypt(limit.toString()),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getProductsOffset(BuildContext context, String name, int offset) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getProductsOffset_test");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode.isNotEmpty
          ? GlobalVariables.logcustomerCode
          : 'null'),
      // 'category': encrypt(name),
      'vendor_code': encrypt(name),
      'offset': encrypt(offset.toString()),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getFavoritesProductsOffset(BuildContext context, int offset) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getFavoritesProducts");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'customer': encrypt(GlobalVariables.logcustomerCode),
      'offset': encrypt(offset.toString()),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future insertremoveFavorites(
    BuildContext context, String itemcode, String action) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/insertremoveFavorites");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'action': encrypt(action),
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'itemcode': encrypt(itemcode),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getSearchProductsOffset(
    BuildContext context, String desc, String cat, int offset) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getSearchProductsOffset");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode.isNotEmpty
          ? GlobalVariables.logcustomerCode
          : 'null'),
      'description': encrypt(desc),
      'category': encrypt(cat),
      'offset': encrypt(offset.toString()),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getSearchProductsBarcodeOffset(
    BuildContext context, String barcode, String cat, int offset) async {
  try {
    var url =
        Uri.parse(ServerUrl.urlCI + "mapiv2/getSearchProductsBarcodeOffset");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode.isNotEmpty
          ? GlobalVariables.logcustomerCode
          : 'null'),
      'barcode': encrypt(barcode),
      'category': encrypt(cat),
      'offset': encrypt(offset.toString()),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getAllItemDesc(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getAllProductDescription");
    final response =
        await http.post(url, headers: {"Accept": "Application/json"}, body: {});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getCustomerServiceUsers(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getCustServiceUsers");
    final response =
        await http.post(url, headers: {"Accept": "Application/json"}, body: {});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future customerLogin(
    BuildContext context, String mobile, String password) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/customerLogin");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'mobile': encrypt(mobile),
      'password': encrypt(password),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future updateActiveDevice(BuildContext context, String accountcode,
    String device, String readdevice) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/updateActiveDevice");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(accountcode),
      'device': encrypt(device),
      'readdevice': encrypt(readdevice),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future changePass(
    BuildContext context, String accountcode, String newpassword) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/changePass");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(accountcode),
      'newpassword': encrypt(newpassword),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future updateAccountLocked(
    BuildContext context, String mobile, String isblock) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/updateAccountLocked");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'mobile': encrypt(mobile),
      'newpassword': encrypt(isblock),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getSpcfcproductCart(BuildContext context, String accountcode,
    String itemcode, String uom) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getSpcfcproductCart");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(accountcode),
      'itemcode': encrypt(itemcode),
      'uom': encrypt(uom),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future insertOnCart(BuildContext context, String accountcode, String itemcode,
    String uom, int qty) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/insertOnCart");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(accountcode),
      'itemcode': encrypt(itemcode),
      'uom': encrypt(uom),
      'qty': encrypt(qty.toString()),
      'chk': encrypt('1'),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getCartItemCount(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getCartItemCount");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text(
      //         "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text("Error: ${response.statusCode}. Internal server error.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    }
  } on TimeoutException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on SocketException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on HttpException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("An HTTP error eccured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on FormatException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("Format exception error occured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  }
}

Future getCustomerCart(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getCustomerCart");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future updateCustomerCartChk(
    BuildContext context, String itemcode, String uom, int chk) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/updateCustomerCartChk");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'itemcode': encrypt(itemcode),
      'uom': encrypt(uom),
      'chk': encrypt(chk.toString()),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future updateCustomerCartQty(
    BuildContext context, String itemcode, String uom, String qty) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/updateCustomerCartQty");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'itemcode': encrypt(itemcode),
      'uom': encrypt(uom),
      'qty': encrypt(qty),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future deleteProductCart(
    BuildContext context, String itemcode, String uom) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/deleteProductCart");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'itemcode': encrypt(itemcode),
      'uom': encrypt(uom),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getMinOrder(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getMinOrder");
    final response =
        await http.post(url, headers: {"Accept": "Application/json"}, body: {});
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future saveOrder(BuildContext context, String paymethod, String itemcount,
    String totAmt, List items) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/saveOrder");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'store_name': encrypt(GlobalVariables.logcustomerName),
      'p_meth': encrypt(paymethod),
      'itm_count': encrypt(itemcount),
      'tot_amt': encrypt(totAmt),
      'tran_stat': encrypt('Pending'),
      'sm_code': encrypt(GlobalVariables.logcustomerSM),
      'applycreditlimit': encrypt(
          GlobalVariables.logcustomerApplyCreditLimit == true
              ? 'true'
              : 'false'),
      'newcredit': encrypt(
          (GlobalVariables.logcustomerCurrentCredit + double.parse(totAmt))
              .toString()),
      'items': json.encode(items),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future saveOrderTranHead(BuildContext context, String paymethod,
    String itemcount, String totAmt) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/saveOrderTranHead");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'store_name': encrypt(GlobalVariables.logcustomerName),
      'p_meth': encrypt(paymethod),
      'itm_count': encrypt(itemcount),
      'tot_amt': encrypt(totAmt),
      'tran_stat': encrypt('Pending'),
      'sm_code': encrypt(GlobalVariables.logcustomerSM),
      'applycreditlimit': encrypt(
          GlobalVariables.logcustomerApplyCreditLimit == true
              ? 'true'
              : 'false'),
      'newcredit': encrypt(
          (GlobalVariables.logcustomerCurrentCredit + double.parse(totAmt))
              .toString()),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future saveOrderTranLine(
  BuildContext context,
  String tranNo,
  String itemCode,
  String itemDesc,
  reqQty,
  uom,
  costAmt,
  totAmt,
) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/saveOrderTranLine");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'tran_no': encrypt(tranNo),
      'itm_code': encrypt(itemCode),
      'item_desc': encrypt(itemDesc),
      'req_qty': encrypt(reqQty),
      'uom': encrypt(uom),
      'amt': encrypt(costAmt),
      'tot_amt': encrypt(totAmt),
      'itm_cat': encrypt(' '),
      'account_code': encrypt(GlobalVariables.logcustomerCode),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future deleteCartChk1(
  BuildContext context,
) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/deleteCartChk1");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'account_code': encrypt(GlobalVariables.logcustomerCode),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getOrderHistory(BuildContext context, int offset) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getOrderHistory");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'account_code': encrypt(GlobalVariables.logcustomerCode),
      'offset': encrypt(offset.toString()),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getOrderHistoryDetail(BuildContext context, String tranno) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getOrderHistoryDetail");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'tran_no': encrypt(tranno),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getOrderHistoryDetailOrderAgain(
    BuildContext context, String tranno) async {
  try {
    var url =
        Uri.parse(ServerUrl.urlCI + "mapiv2/getOrderHistoryDetailOrderAgain");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'tran_no': encrypt(tranno),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future checkCustomerMobileSendCode(BuildContext context, String mobile,
    String completemobile, String code) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/checkCustomerMobileSendCode");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'mobile': encrypt(mobile),
      'completemobile': encrypt(completemobile),
      'code': encrypt(code),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future checkMobileSignup(BuildContext context, String mobile) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/checkMobileSignup");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'mobile': encrypt(mobile),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future register(BuildContext context, String password, String photoName) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/register");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'ownername': encrypt(GlobalVariables.ownerName),
      'mobilenumber': encrypt(GlobalVariables.mobile),
      'telephonenumber': encrypt(GlobalVariables.telephone),
      'streetadd': encrypt(GlobalVariables.sitio),
      'landmark': encrypt(GlobalVariables.landmark),
      'municipality': encrypt(GlobalVariables.stown),
      'mun_code': encrypt(GlobalVariables.stownCode),
      'barangay': encrypt(GlobalVariables.sbarangay),
      'bar_code': encrypt(GlobalVariables.sbarangayCode),
      'storename': encrypt(GlobalVariables.storeName),
      'dtino': encrypt(GlobalVariables.dti),
      'storephoto': encrypt(photoName),
      'bcphoto': encrypt(photoName),
      'temppassword': encrypt(password),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future uploadPhoto(BuildContext context, String photoDir, String photoPath,
    String filename) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/uploadPhoto");
    var request = http.MultipartRequest('POST', url);
    request.fields['filename'] = filename;
    request.fields['photoDirectory'] = photoDir;
    var photo = await http.MultipartFile.fromPath("image", photoPath);
    request.files.add(photo);
    var response = await request.send();

    if (response.statusCode == 200) {
      return 'Uploaded';
    } else {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Connection failed. Try again later.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getActiveDevice(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getActiveDevice");
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {'accountcode': encrypt(GlobalVariables.logcustomerCode)});
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text(
      //         "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text("Error: ${response.statusCode}. Internal server error.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    }
  } on TimeoutException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on SocketException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on HttpException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("An HTTP error eccured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on FormatException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("Format exception error occured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  }
}

Future sendFeedback(BuildContext context, String feedback) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/sendFeedback");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'feedback': encrypt(feedback),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future sendAppRate(BuildContext context, int rate) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/sendAppRate");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'rate': encrypt(rate.toString()),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getSimilarProducts(BuildContext context, String itemcode, String family,
    String keyword, int offset) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getSimilarProducts");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'customer': encrypt(GlobalVariables.logcustomerCode),
      'itemcode': encrypt(itemcode),
      'family': encrypt(family),
      'keyword': encrypt(keyword),
      'offset': encrypt(offset.toString()),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getContacts(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getContacts");
    final response =
        await http.post(url, headers: {"Accept": "Application/json"}, body: {});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

/////CHAT

Future insertChatReply(BuildContext context, String refno, String msg) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/insertChatReply");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'refno': encrypt(refno),
      'msg': encrypt(msg),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future insertNewConvo(
    BuildContext context, String csrid, String csrname, String msg) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/insertChatConvo");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'csrid': encrypt(csrid),
      'csrname': encrypt(csrname),
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
      'msg': encrypt(msg),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
          () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
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
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
        () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
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
}

Future getChatCount(BuildContext context) async {
  try {
    var url = Uri.parse(ServerUrl.urlCI + "mapiv2/getChatCount");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': encrypt(GlobalVariables.logcustomerCode),
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(decrypt(response.body));
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text(
      //         "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text("Error: ${response.statusCode}. Internal server error.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    }
  } on TimeoutException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on SocketException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on HttpException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("An HTTP error eccured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on FormatException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("Format exception error occured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  }
}
