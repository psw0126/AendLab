// ignore_for_file: prefer_if_null_operators

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';


import 'package:aendlab/api/exception.dart';
import 'package:aendlab/api/response.dart';
import 'package:aendlab/model/error.dart';
import 'package:aendlab/model/user.dart';
import 'package:aendlab/preference.dart';

import 'package:aendlab/router/routes_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class APIClient {
  static const Duration _API_TIMEOUT_DURATION = const Duration(seconds: 30);

  static var id = "";
  static var pw = "";

  static late APIClient _singleton;

  final Client _client = Client();
  final String _url;

  factory APIClient({String? url}) {
    _singleton = APIClient._internal(
        url == null ? _singleton._url : url
    );

    return _singleton;
  }

  APIClient._internal(String url)
      : this._url = url {
    if (_client == null) {
      throw Exception("HTTP client: unsupported platform.");
    }
  }



  Future<void> login(String id, String pw) async {
    var res = await _callPOST("login", {
      "account_id": id,
      "password": pw,
    });
    await Preference(res!["token"], UserDTO.fromJson(res["user"]));
  }

  // Future<void> login(String id, String pw) async {
  //   dynamic res = await _callGET("product/search", {
  //     "account_id": id,
  //     "password": pw,
  //   });
  //   await Preference(res["token"], UserDTO.fromJson(res["user"]));
  // }

  // Future<dynamic> _callGET(String method, Map<String, dynamic> params) async {
  //
  //   try {
  //     dynamic header = {
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       // "Authorization": "bearer Zs7bvT4rt4eocybf2ePFWlXvH8aTmYclc+9MbAJqTSZKQ2UqYYdQ39uoJc51A1zj"
  //     };
  //
  //     // var url = Uri.parse(
  //     //   'http://aend.iptime.org:7020/v1/product/search',
  //     // );
  //     // var response = await http.get(url);
  //     // print('Response status: ${response.statusCode}');
  //     // print('Response body: ${response.body}');
  //
  //     dynamic response = await _client.get(Uri.parse(_url + "/" + method),
  //       headers: header,
  //     ).timeout(
  //       _API_TIMEOUT_DURATION,
  //       onTimeout: () {
  //         throw TimeoutException("connection timeout exceeded");
  //       },
  //     );
  //     print('리스폰');
  //     print(response);
  //
  //     if (response.statusCode != 200) {
  //       if (response.statusCode == 400) {
  //         Modular.to.pushReplacementNamed(RouteMap.LOGIN.page);
  //         return;
  //       }
  //
  //       throw APIException(
  //         httpStatus: response.statusCode,
  //         errorMessage: "unexpected HTTP status code: ${response.statusCode}",
  //       );
  //     }
  //
  //     String httpBody = utf8.decode(response.bodyBytes);
  //     print('123');
  //     print(httpBody);
  //     APIResponse res = APIResponse.fromJson(json.decode(httpBody));
  //     print('호출');
  //
  //     if (res.status != APIStatus.Okay) {
  //       throw APIException(
  //         httpStatus: response.statusCode,
  //         errorCode: res.status,
  //         errorMessage: res.message,
  //       );
  //     }
  //
  //     return res.data;
  //   } catch (e) {
  //     if (e is SocketException) {
  //       print(
  //           "client socket exception: address=${e.address}, port=${e.port}, message=${e.message}");
  //     } else if (e is APIException) {
  //       print(
  //           "client api exception: errorCode=${e.errorCode}, message=${e.errorMessage}, httpStatus=${e.httpStatus}");
  //       switch (e.errorCode) {
  //         case APIStatus.IncorrectAuthCode:
  //           FlutterError.reportError(FlutterErrorDetails(exception: e));
  //           break;
  //         default:
  //           break;
  //       }
  //       rethrow;
  //     } else {
  //       print("client exception: $e");
  //     }
  //   }
  // }

  Future<dynamic> _callPOST(String method, Map<String, dynamic>? params) async {
    try {
      Map<String, String> header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "bearer 5w+PfYG3n7qzfbg40/x7UEA0FEDBZqZRV2M1drHLXPAq1byc/xfSqrUNlgK1ypnA"
      };


      Object? body;
      if (params != null) {
        body = json.encode(params);
      }

      // var url = Uri.parse(
      //   'http://aend.iptime.org:7020/v1/product/search',
      // );
      // var response = await http.get(url);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      Response response = await _client.post(Uri.parse(_url + "/" + method),
        body: body,
        headers: header,
      );


      // print(Errbody);

      // if (response.statusCode != "200") {
      //   if (response.statusCode == "401") {
      //     Modular.to.pushReplacementNamed(RouteMap.LOGIN.page);
      //     return;
      //   }
      //   throw APIException(
      //     httpStatus: response.statusCode,
      //     errorMessage: "unexpected HTTP status code: ${response.statusCode}",
      //     errorCode: jsonDecode(response.body)['error'],
      //   );
      // }


      String? httpBody = utf8.decode(response.bodyBytes);
      print(httpBody);
      print('프린트');
      APIResponse res = APIResponse.fromJson(json.decode(httpBody));
      // var res = json.decode(httpBody);

      print(res);

      return res;
    } catch (e) {
      if (e is SocketException) {
        print(
            "client socket exception: address=${e.address}, port=${e.port}, message=${e.message}");
      } else if (e is APIException) {
        print(
            "client api exception: errorCode=${e.errorCode}, message=${e.errorMessage}, httpStatus=${e.httpStatus}");
        rethrow;
      } else {
        print("client exception: $e");
      }
    }
  }
}
