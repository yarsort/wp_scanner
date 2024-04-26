import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wp_scanner/controllers/api_controller.dart';
import 'package:wp_scanner/models/ref_product.dart';

// Get all products
Future<ApiResponse> getProducts(
    String uidParentProduct, Sort sortDefault, String uidPrice, String uidWarehouse, String searchString) async {
  ApiResponse apiResponse = ApiResponse();

  /// Адрес подключения: отправка!!!
  var connectionUrl = '${await getBaseUrl()}/products';

  /// Authorization
  String basicAuth = await getToken();
  if (basicAuth == '') {
    apiResponse.error = unauthorized;
    return apiResponse;
  }

  /// Get data from server
  try {
    connectionUrl =
        '$connectionUrl?sort=${sortDefault.code}&uidParentProduct=$uidParentProduct&uidPrice=$uidPrice&uidWarehouse=$uidWarehouse';

    if (searchString.trim() != '') {
      connectionUrl = '$connectionUrl&search=${searchString.trim()}';
    }

    var dio = Dio();
    dio.options.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    dio.options.headers[HttpHeaders.authorizationHeader] = basicAuth;
    dio.options.headers[HttpHeaders.wwwAuthenticateHeader] = basicAuth;

    final response = await dio.get(connectionUrl);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = response.data['data'].map((p) => Product.fromJson(p)).toList();
        // We get list of order customer, so we need to map each item to OrderCustomer model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = 'Помилка отримання списку товарів';
        break;
    }
  } on DioException catch (e) {
    debugPrint(e.toString());
    apiResponse.error = "$somethingWentWrong\n$e";
  }
  return apiResponse;
}

Future<ApiResponse> getProductCharacteristic(uidProduct) async {
  ApiResponse apiResponse = ApiResponse();

  /// Адрес подключения: отправка!!!
  final connectionUrl = '${await getBaseUrl()}/product_characteristics';

  /// Authorization
  String basicAuth = await getToken();
  if (basicAuth == '') {
    apiResponse.error = unauthorized;
    return apiResponse;
  }

  /// Get data from server
  try {
    var dio = Dio();
    final response = await dio.get('$connectionUrl/' + uidProduct,
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: basicAuth,
        }));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = response.data['data'].map((p) => ProductCharacteristic.fromJson(p)).toList();
        // We get list of order customer, so we need to map each item to OrderCustomer model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = 'Помилка отримання списку характеристик товару';
        break;
    }
  } on DioException catch (e) {
    debugPrint(e.toString());
    apiResponse.error = "$somethingWentWrong\n$e";
  }
  return apiResponse;
}

// Get prices of products
Future<ApiResponse> getAccumProductPriceByUIDProducts(List<String> listPricesUID, List<String> listProductsUID) async {
  ApiResponse apiResponse = ApiResponse();

  /// Адрес подключения: отправка!!!
  final connectionUrl = '${await getBaseUrl()}/products_prices';

  /// Authorization
  String basicAuth = await getToken();
  if (basicAuth == '') {
    apiResponse.error = unauthorized;
    return apiResponse;
  }

  /// Get data from server
  try {
    Map dataMap = {
      'uidPrices': listPricesUID,
      'uidProducts': listProductsUID,
    };

    var dio = Dio();
    final response = await dio.post(connectionUrl,
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: basicAuth,
        }),
        data: jsonEncode(dataMap));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = response.data['data'].map((p) => AccumProductPrice.fromJson(p)).toList();
        // We get list of order customer, so we need to map each item to OrderCustomer model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = 'Помилка отримання цін';
        break;
    }
  } on DioException catch (e) {
    debugPrint(e.toString());
    apiResponse.error = "$somethingWentWrong\n$e";
  }
  return apiResponse;
}

// Get rests of products
Future<ApiResponse> getAccumProductRestByUIDProducts(
    List<String> listWarehousesUID, List<String> listProductsUID) async {
  ApiResponse apiResponse = ApiResponse();

  /// Адрес подключения: отправка!!!
  final connectionUrl = '${await getBaseUrl()}/products_rests';

  /// Authorization
  String basicAuth = await getToken();
  if (basicAuth == '') {
    apiResponse.error = unauthorized;
    return apiResponse;
  }

  /// Get data from server
  try {
    Map dataMap = {
      'uidWarehouses': listWarehousesUID,
      'uidProducts': listProductsUID,
    };

    var dio = Dio();
    final response = await dio.post(connectionUrl,
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: basicAuth,
        }),
        data: jsonEncode(dataMap));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = response.data['data'].map((p) => AccumProductRest.fromJson(p)).toList();
        // We get list of order customer, so we need to map each item to OrderCustomer model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = 'Помилка отримання залишків';
        break;
    }
  } on DioException catch (e) {
    debugPrint(e.toString());
    apiResponse.error = "$somethingWentWrong\n$e";
  }
  return apiResponse;
}

// Get pictures of product
Future<ApiResponse> getProductPictures(uidProduct) async {
  ApiResponse apiResponse = ApiResponse();

  /// Адрес подключения: отправка!!!
  var connectionUrl = '${await getBaseUrl()}/images';

  /// Authorization
  String basicAuth = await getToken();
  if (basicAuth == '') {
    apiResponse.error = unauthorized;
    return apiResponse;
  }

  /// Get data from server
  try {
    connectionUrl = '$connectionUrl?uidProduct=$uidProduct';

    var dio = Dio();
    dio.options.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    dio.options.headers[HttpHeaders.authorizationHeader] = basicAuth;
    dio.options.headers[HttpHeaders.wwwAuthenticateHeader] = basicAuth;

    final response = await dio.get(connectionUrl);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = response.data['data'].map((p) => ProductImage.fromJson(p)).toList();

        // We get list of order customer, so we need to map each item to OrderCustomer model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = 'Помилка отримання списку характеристик товару';
        break;
    }
  } on DioException catch (e) {
    debugPrint(e.toString());
    apiResponse.error = "$somethingWentWrong\n$e";
  }
  return apiResponse;
}
