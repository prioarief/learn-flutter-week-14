import 'dart:convert';

import 'package:tokoumb/helper/api.dart';
import 'package:tokoumb/helper/api_url.dart';
import 'package:tokoumb/model/registrasimodel.dart';

class RegistrasiBloc {
  static Future<RegistrasiModel> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {"nama": nama, "email": email, "password": password};

    print("Body : $body, apiUrl: $apiUrl, body: $body");

    var response = await Api().post(apiUrl, body);

    print("response value : $response");
    var jsonObj = json.decode(response.body);
    print("json object : $jsonObj");

    return RegistrasiModel.fromJson(jsonObj);
  }
}
