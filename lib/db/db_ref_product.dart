import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wp_scanner/controllers/api_controller.dart';
import 'package:wp_scanner/models/ref_product.dart';

///**************************************
/// WEB Read
///**************************************

Future<List<Product>> dbReadProductsFromWeb(uidParent, searchString) async {
  /// Connection address
  String connectionUrl = await getBaseUrl() + '/products?uid_parent=' + uidParent + '&search_string=' + searchString;

  List<Product> listData = [];

  /// Get data from server
  try {
    var dio = Dio();
    final response = await dio.get(connectionUrl,
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          HttpHeaders.contentTypeHeader: 'application/json',
        }));

    switch (response.statusCode) {
      case 200:
        ApiResponse responseData = ApiResponse();
        responseData.data = response.data['data'].map((p) => Product.fromJson(p)).toList();
        for (var item in responseData.data as List<dynamic>) {
          listData.add(item);
        }
        return listData;
      default:
        return listData;
    }
  } on DioError catch (e) {
    return listData;
  }
}

Future<List<Product>> dbReadSellProductsFromWeb(uidSell, searchString) async {
  /// Connection address
  String connectionUrl = await getBaseUrl() + '/products?uid_sell=' + uidSell + '&search_string=' + searchString;

  List<Product> listData = [];

  /// Get data from server
  try {
    var dio = Dio();
    final response = await dio.get(connectionUrl,
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          HttpHeaders.contentTypeHeader: 'application/json',
        }));

    switch (response.statusCode) {
      case 200:
        ApiResponse responseData = ApiResponse();
        responseData.data = response.data['data'].map((p) => Product.fromJson(p)).toList();
        for (var item in responseData.data as List<dynamic>) {
          listData.add(item);
        }
        return listData;
      default:
        return listData;
    }
  } on DioError catch (e) {
    return listData;
  }
}

Future<Product> dbReadProductByBarcodeFromWeb(productBarcode) async {
  /// Connection address
  String connectionUrl = await getBaseUrl();

  Product product = Product();

  Map dataMap = {
    'method': 'getProductByBarcode',
    'barcode': productBarcode,
    'authorization': '00000000-0000-0000-0000-000000000125',
  };

  /// Get data from server
  try {
    var dio = Dio();
    final response = await dio.post(connectionUrl,
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
        data: jsonEncode(dataMap));

    switch (response.statusCode) {
      case 200:
        ApiResponse responseData = ApiResponse();
        responseData.data = response.data['data'].map((p) => Product.fromJson(p)).toList();
        for (var item in responseData.data as List<dynamic>) {
          product = item;
        }
        return product;
      default:
        return product;
    }
  } on DioError catch (e) {
    return product;
  }
}
