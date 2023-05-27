import 'dart:convert';

import 'package:tokoumb/helper/api.dart';
import 'package:tokoumb/helper/api_url.dart';
import 'package:tokoumb/model/registrasimodel.dart';

class LoginBloc {
  static Future<RegistrasiModel> registrasi(
      {String? email, String? password}) async {
        
    String apiUrl = ApiUrl.registrasi;

    var body = {email, password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body());

    return RegistrasiModel.fromJson(jsonObj);
  }
}
