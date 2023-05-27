import 'dart:convert';

import 'package:tokoumb/helper/api.dart';
import 'package:tokoumb/helper/api_url.dart';
import 'package:tokoumb/model/loginmodel.dart';

class LoginBloc {
  static Future<LoginModel> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;

    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);

    var jsonObj = json.decode(response.body);
    print("json obj $jsonObj");

    return LoginModel.fromJson(jsonObj);
  }
}
