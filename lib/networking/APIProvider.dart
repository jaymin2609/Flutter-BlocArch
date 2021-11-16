import 'dart:convert';

import 'package:http/http.dart';

import 'Response.dart';
import 'ReturnType.dart';

class APIProvider {
  Future<ResponseData> getCall(ReturnType returnType, String url) async {
    try {
      Response result = await get(url);
      var responseJson = _response(result);

      print('respons : ${responseJson}');

      return ResponseData(
          returnType: returnType,
          status: STATUS.SUCCESS,
          data: responseJson,
          msg: '');
    } catch (e) {
      return ResponseData(
          returnType: returnType, status: STATUS.ERROR, msg: e.toString());
    }
  }


  Future<ResponseData> postCall(
      ReturnType returnType, String url, String jsonBody) async {
    try {
      print('jsonBody : ${jsonBody}');
      Response result = await post(url, body: jsonBody);
      var responseJson = _response(result);

      print('response : ${result.body.toString()}');

      return ResponseData(
          returnType: returnType,
          status: STATUS.SUCCESS,
          data: responseJson,
          msg: '');
    } catch (e) {
      return ResponseData(
          returnType: returnType, status: STATUS.ERROR, msg: e.toString());
    }
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
        throw Exception(response.body.toString());
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
