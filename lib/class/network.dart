import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';

String BASE_URL = "https://lancar-jaya-abadi.com";
// String BASE_URL = "https://lancar-jaya-abadi.com";

class Api {
  static final Api _api = new Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();
  var dio = Dio();
  init() {}

  //login
  Future<dynamic> loginApi(Map<String, dynamic> map) async {
    try {

      Response response =
          await dio.post("$BASE_URL" + "/api/login_system.php", data: map);

      // print(response);
      return response.data;
    } catch (e) {
      print(e);

      return null;
    }
  }

  //product get all
  Future<dynamic> productGet() async {
    try {
      Response response = await dio.get("$BASE_URL" + "/api/product.php");
      // String dataJsonEncode = jsonEncode(response.data);
      List<dynamic> temp = jsonDecode(response.data);
      return temp;
    } catch (e) {
      print(e);
    }
  }

  //product post
  Future<dynamic> productPost(Map<String, dynamic> map) async {
    try {
      dio.options.headers = {
        "Accept": "application/json",
      };

      Response response =
          await dio.post("$BASE_URL" + "/api/tambah_produk.php", data: map);

      print(response);

      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  //product edit
  Future<dynamic> productEdit(Map<String, dynamic> map) async {
    try {
      dio.options.headers = {
        "Accept": "application/json",
      };

      Response response =
          await dio.post("$BASE_URL" + "/api/edit_barang.php", data: map);

      print(response);

      return response.data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  
  //product search
  Future<dynamic> productSearch(Map<String, dynamic> map) async {
    try {
      Response response = await dio.post("$BASE_URL" + "/api/search_barang.php", data:map);
      // String dataJsonEncode = jsonEncode(response.data);
      List<dynamic> temp = jsonDecode(response.data);
      return temp;
    } catch (e) {
      print(e);
    }
  }
  
}
