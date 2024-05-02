import 'package:shared_preferences/shared_preferences.dart';

/// Errors
const serverError = 'Помилка отримання даних. Сервер не доступний!';
const serverAuthError = 'Помилка авторизації. Сервер не доступний!';
const unauthorized = 'Помилка авторизації!';
const somethingWentWrong = 'Помилка сервера, спробуйте повторити дію!';

/// Get base url
Future<String> getBaseUrl() async {
  return 'https://api1.wptrade.com.ua:35755/moto/hs/wpscanner/getdata/';
}

/// Get photo base url
Future<String> getBasePhotoUrl() async {
  var nameServer = Uri.base.host + '/image';

  return nameServer;
}

/// Get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';

  // String username = 'Администратор';
  // String password = 'jkloofege74';
  // String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  // return basicAuth;
}

/// Система.ОтветСервера
class ApiResponse {
  Object? data;
  String? error;
}

/// Система.Сортировка
class Sort {
  int type = 0; // Тип сортировки
  String code = ''; // Код для 1С
  String name = ''; // Имя сортировки

  List<Sort> listSortProduct = [];

  Sort();

  Sort.fromJson(Map<String, dynamic> json) {
    type = 0;
    code = json['code'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = 0;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
