import 'dart:io';

import 'package:code_management_app/util/api_path.dart';
import 'package:code_management_app/util/response_obj.dart';
import 'package:http/http.dart' as http;

class BaseRequest {
  Future<Map<String, String>> getHeader() async {
    return {
      "Accept": "application/json",
    };
  }

  Future<ResponseObj> getRequest({String? endUrl}) async {
    return await getHeader().then((header) async {
      print("Header --- " + header.toString());
// Important Header
      ResponseObj rv = ResponseObj();
      return await http
          .get(Uri.parse(BASE_URL + endUrl!), headers: header)
          .then((res) {
        print(
            "GET REQUEST ==========> ${res.request!.url} ${res.statusCode.toString()}" +
                res.body.toString());

        if (res.statusCode == 200) {
          rv.message = MsgState.data;
          rv.data = res.body.toString();
        } else {
          rv.message = MsgState.error;
          rv.data = "Data Fetching Error";
        }
        return rv;
      }).catchError((e) {
        if (e is SocketException) {
          rv.message = MsgState.error;
          rv.data = "No Internet";
        } else {
          rv.message = MsgState.error;
          rv.data = "Data ${e.toString()} Error";
        }
        return rv;
      });
    });
  }
}
