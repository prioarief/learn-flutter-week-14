import 'dart:convert';

import 'package:tokoumb/helper/api.dart';
import 'package:tokoumb/helper/api_url.dart';
import 'package:tokoumb/model/produkmodel.dart';

class ProdukBloc {
  static Future<List<ProdukModel>> getProduk() async {
    String apiUrl = ApiUrl.listProduk;

    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);

    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<ProdukModel> produks = [];

    for (var i = 0; i < listProduk.length; i++) {
      var e = listProduk[i];
      var produk = {
        "id": int.parse(e['id']),
        "hargaproduk": int.parse(e['hargaproduk']),
        "kodeproduk": e['kodeproduk'],
        "namaproduk": e['namaproduk']
      };

      produks.add(ProdukModel.fromJson(produk));
    }

    return produks;
  }

  static Future addProduk({ProdukModel? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk!.kodeproduk,
      "nama_produk": produk.namaproduk,
      "harga_produk": produk.hargaproduk.toString(),
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);

    return jsonObj['status'];
  }

  static Future updateProduk({required ProdukModel produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    var body = {
      "kode_produk": produk.kodeproduk,
      "nama_produk": produk.namaproduk,
      "harga": produk.hargaproduk.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map)['data'];
  }
}
