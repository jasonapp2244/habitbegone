import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getxmvvm/data/app_exception.dart';
import 'package:getxmvvm/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getDeleteApiResponse(String url) {
    throw UnimplementedError();
  }

  @override
  Future getGetApiResponse(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = retrunResponse(response);
    } on SocketException {
      throw InternetException("Please check your internet connection.");
    } on TimeoutException {
      throw RequestTimeOut("Request time out please try again.");
    }

    return responseJson;
  }

  dynamic retrunResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException("Inavalid URL");
      default:
        throw FetchdataException(
          "Error While Communicating With Server ${response.statusCode.toString()}" 
        );
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic data,Map<String,String> header) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(data),
            headers:header
          )
          .timeout(const Duration(seconds: 10));
      responseJson = retrunResponse(response);
    } on SocketException {
      throw InternetException("Please check your internet connection.");
    } on TimeoutException {
      throw RequestTimeOut("Request time out please try again.");
    }

    return responseJson;
  }

  @override
  Future getPutApiResponse(
    String url,
    String body, {
    Map<String, String>? headers,
  }) {
    throw UnimplementedError();
  }
}
