// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tokoumb/helper/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJSON;

    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin':
            '*', // Allow requests from any origin (replace * with specific origins if needed)
        'Access-Control-Allow-Methods':
            'GET, POST, PUT, DELETE, OPTIONS', // Allow specific HTTP methods
        'Access-Control-Allow-Headers':
            'Origin, Content-Type, Accept', // Allow specific headers
      });

      print('response >>>');
      print(response.statusCode);

      responseJSON = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (err) {
      print('error post api');
      print(err);
    }

    print('response 2');
    print(responseJSON);

    return responseJSON;
  }

  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJSON;

    try {
      final response = await http.get(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

      responseJSON = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJSON;
  }

  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJSON;

    try {
      final response = await http.delete(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

      responseJSON = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJSON;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            "Error with status code : ${response.statusCode}");
    }
  }
}
