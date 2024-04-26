import 'package:shared_preferences/shared_preferences.dart';

/// Errors
const serverError = 'Помилка отримання даних. Сервер не доступний!';
const serverAuthError = 'Помилка авторизації. Сервер не доступний!';
const unauthorized = 'Помилка авторизації!';
const somethingWentWrong = 'Помилка сервера, спробуйте повторити дію!';

/// Get base url
Future<String> getBaseUrl() async {
  var nameServer = Uri.base.host;

  switch (nameServer) {
    case 'musclefood.wptrade.com.ua':
      return 'https://api1.wptrade.com.ua:37745/muscle/hs/portal'; // 443 port
    case 'tlt.wptrade.com.ua':
      return 'https://api1.wptrade.com.ua:35745/tlt_utp/hs/portal'; // 443 port
    case 'rsvmoto.wptrade.com.ua':
      return 'https://api1.wptrade.com.ua:35755/moto/hs/portal'; // 443 port

    case 'tehnikaua.wptrade.com.ua':
      return 'http://api-teh.yarsoft.com.ua/baza/hs/portal';

    // /// RSV-MOTO
    // case 'portal.rsvmoto.com.ua':
    //   return 'https://api1.wptrade.com.ua:35945/moto/hs/portal';

    /// TLT
    case 'portal.tlt.com.ua':
      return 'http://api-tehno.yarsoft.com.ua:35744/tlt_utp/hs/portal';

    /// Parkaudio
    case 'portal.parkaudio.eu':
      return 'http://85.159.4.233:1080/utp/hs/portal';

    /// TEHNIKA.UA
    case 'portal.tehnikaua.com.ua':
      return 'http://api-teh.yarsoft.com.ua/baza/hs/portal';

    /// TEHNIKA.UA
    case 'localhost':
      return 'http://api1.wptrade.com.ua:35944/moto/hs/portal';

    default:
      return 'http://api1.wptrade.com.ua:35944/moto/hs/portal'; // 80 port
    //return 'http://api-teh.yarsoft.com.ua/baza/hs/portal';
  }
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
