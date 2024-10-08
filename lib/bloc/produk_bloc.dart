import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  // Fetch list of products
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    
    var response = await Api().get(apiUrl);
    
    // Cek apakah request berhasil (status code 200)
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      
      // Safely parse the response
      List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
      List<Produk> produks = listProduk.map((item) => Produk.fromJson(item)).toList();
      return produks;
    } else {
      // Kembalikan list kosong jika ada masalah dengan respons
      return [];
    }
  }

  // Add new product
  static Future<bool> addProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.createProduk;
    
    // Create body with necessary data
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };
    
    var response = await Api().post(apiUrl, body);
    
    // Cek apakah request berhasil
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == 'success';
    } else {
      return false; // Return false jika gagal
    }
  }

  // Update existing product
  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);
    
    // Body for update request
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    var response = await Api().put(apiUrl, body);
    
    // Cek apakah request berhasil
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == 'success';
    } else {
      return false; // Return false jika gagal
    }
  }

  // Delete product by ID
  static Future<bool> deleteProduk({required int id}) async {
    String apiUrl = ApiUrl.deleteProduk(id);
    
    var response = await Api().delete(apiUrl);
    
    // Cek apakah request berhasil
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == 'success';
    } else {
      return false; // Return false jika gagal
    }
  }
}
