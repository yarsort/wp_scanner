/// Номенклатура
class Product {
  int isGroup = 0; // Пометка удаления
  String uid = ''; // UID для 1С и связи с ТЧ
  String code = ''; // Код для 1С
  String name = ''; // Имя
  String nameForSearch = ''; // Имя для поиска
  String vendorCode = ''; // Артикул товара в 1С
  String uidParent = ''; // Посилання на группу
  bool useCharacteristic = false; // Имя
  String uidUnit = ''; // Посилання на единицу измерения
  String nameUnit = ''; // Имя ед. изм.
  String uidProductGroup = ''; // Посилання на номенклатурную групу
  String nameProductGroup = ''; // Имя номенклатурной группы
  String codeUKTZED = ''; // Код УКТЗЕД ліцензійного товару
  String barcode = ''; // Штрихкод.
  String numberTaxGroup = '1'; // Номер податкової групи
  String description = ''; // Опис товару
  String comment = ''; // Коммментарий
  String picture = ''; // Картинка основная
  DateTime dateEdit = DateTime.now(); // Дата редактирования

  List<ProductCharacteristic> characteristics = [];
  List<ProductProperty> properties = [];
  List<ProductImage> images = [];
  List<AccumProductPrice> prices = [];
  List<AccumProductRest> rests = [];

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    isGroup = int.parse(json['isGroup'] ?? 0);
    uid = json['uid'] ?? '';
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    nameForSearch = json['name'].toLowerCase() ?? '';
    vendorCode = json['vendorCode'] ?? '';
    uidParent = json['uidParent'] ?? '';
    useCharacteristic = (json['useCharacteristic'] == '1') ? true : false;
    uidUnit = json['uidUnit'] ?? '';
    nameUnit = json['nameUnit'] ?? '';
    uidProductGroup = json['uidProductGroup'] ?? '';
    nameProductGroup = json['nameProductGroup'] ?? '';
    numberTaxGroup = json['numberTaxGroup'] ?? '1';
    codeUKTZED = json['codeUKTZED'] ?? '';
    barcode = json['barcode'] ?? '';
    description = json['description'] ?? '';
    comment = json['comment'] ?? '';
    picture = json['picture'] ?? '00000000-0000-0000-0000-000000000000';
    dateEdit = DateTime.parse(json['dateEdit'] ?? DateTime.now().toIso8601String());

    if (json['characteristics'] != null) {
      characteristics =
          List<dynamic>.from(json['characteristics']).map((i) => ProductCharacteristic.fromJson(i)).toList();
    }
    if (json['properties'] != null) {
      properties = List<dynamic>.from(json['properties']).map((i) => ProductProperty.fromJson(i)).toList();
    }
    if (json['images'] != null) {
      images = List<dynamic>.from(json['images']).map((i) => ProductImage.fromJson(i)).toList();
    }
    if (json['prices'] != null) {
      prices = List<dynamic>.from(json['prices']).map((i) => AccumProductPrice.fromJson(i)).toList();
    }
    if (json['rests'] != null) {
      rests = List<dynamic>.from(json['rests']).map((i) => AccumProductRest.fromJson(i)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isGroup'] = isGroup;
    data['uid'] = uid;
    data['code'] = code;
    data['name'] = name;
    data['nameForSearch'] = nameForSearch;
    data['vendorCode'] = vendorCode;
    data['uidParent'] = uidParent;
    data['useCharacteristic'] = useCharacteristic ? '1' : '0';
    data['uidUnit'] = uidUnit;
    data['nameUnit'] = nameUnit;
    data['uidProductGroup'] = uidProductGroup;
    data['nameProductGroup'] = nameProductGroup;
    data['numberTaxGroup'] = numberTaxGroup;
    data['barcode'] = barcode;
    data['codeUKTZED'] = codeUKTZED;
    data['description'] = description;
    data['comment'] = comment;
    data['picture'] = picture;
    data['dateEdit'] = dateEdit.toIso8601String();
    data['characteristics'] = characteristics.map((e) => e.toJson()).toList();
    data['properties'] = properties.map((e) => e.toJson()).toList();
    data['images'] = images.map((e) => e.toJson()).toList();
    data['prices'] = prices.map((e) => e.toJson()).toList();
    data['rests'] = rests.map((e) => e.toJson()).toList();
    return data;
  }
}

/// Характеристики номенклатуры
class ProductCharacteristic {
  String uid = ''; // UID для 1С и связи с ТЧ
  String code = ''; // Код для 1С
  String vendorCode = ''; // Имя
  String name = ''; // Имя
  String uidProduct = ''; // Посилання на родителя (Товар)
  String barcode = ''; // Штрихкод.
  String comment = ''; // Коммментарий

  List<AccumProductPrice> prices = [];
  List<AccumProductRest> rests = [];

  ProductCharacteristic();

  ProductCharacteristic.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    code = json['code'] ?? '';
    vendorCode = json['vendorCode'] ?? '';
    name = json['name'] ?? '';
    uidProduct = json['uidProduct'] ?? '';
    barcode = json['barcode'] ?? '';
    comment = json['comment'] ?? '';
    if (json['prices'] != null) {
      prices = List<dynamic>.from(json['prices']).map((i) => AccumProductPrice.fromJson(i)).toList();
    }
    if (json['rests'] != null) {
      rests = List<dynamic>.from(json['rests']).map((i) => AccumProductRest.fromJson(i)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['code'] = code;
    data['vendorCode'] = vendorCode;
    data['name'] = name;
    data['uidProduct'] = uidProduct;
    data['barcode'] = barcode;
    data['comment'] = comment;
    data['prices'] = prices.map((e) => e.toJson()).toList();
    data['rests'] = rests.map((e) => e.toJson()).toList();
    return data;
  }
}

/// Свойства номенклатуры
class ProductProperty {
  String uid = ''; // UID для 1С и связи с ТЧ
  String name = ''; // Имя
  String uidValue = ''; // Имя
  String nameValue = ''; // Имя
  String uidProduct = ''; // Посилання на родителя (Товар)
  String comment = ''; // Коммментарий

  ProductProperty();

  ProductProperty.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    name = json['name'] ?? '';
    uidValue = json['uidValue'] ?? '';
    nameValue = json['nameValue'] ?? '';
    uidProduct = json['uidProduct'] ?? '';
    comment = json['comment'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['uidValue'] = uidValue;
    data['nameValue'] = nameValue;
    data['uidProduct'] = uidProduct;
    data['comment'] = comment;
    return data;
  }
}

/// Картинки номенклатуры
class ProductImage {
  String uid = ''; // UID для 1С и связи с ТЧ
  String name = ''; // Имя
  String uidProduct = ''; // Посилання на родителя (Товар)
  String comment = ''; // Коммментарий

  ProductImage();

  ProductImage.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    name = json['name'] ?? '';
    uidProduct = json['uidProduct'] ?? '';
    comment = json['comment'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['uidProduct'] = uidProduct;
    data['comment'] = comment;
    return data;
  }
}

/// Цены номенклатуры
class AccumProductPrice {
  String uidPrice = '';
  String namePrice = '';
  String uidProduct = '';
  String uidProductCharacteristic = '';
  String uidUnit = '';
  String nameCurrency = '';
  double price = 0.0;
  double course = 0.0;
  double multiplicity = 0.0;

  AccumProductPrice();

  AccumProductPrice.fromJson(Map<String, dynamic> json) {
    uidPrice = json["uidPrice"] ?? '';
    namePrice = json["namePrice"] ?? '';
    uidProduct = json["uidProduct"] ?? '';
    uidProductCharacteristic = json["uidProductCharacteristic"] ?? '';
    uidUnit = json["uidUnit"] ?? '';
    nameCurrency = json["nameCurrency"] ?? '';
    price = double.parse(json["price"].toString());
    course = double.parse(json["course"].toString());
    multiplicity = double.parse(json["multiplicity"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uidPrice'] = uidPrice;
    data['namePrice'] = namePrice;
    data['uidProduct'] = uidProduct;
    data['uidProductCharacteristic'] = uidProductCharacteristic;
    data['uidUnit'] = uidUnit;
    data['nameCurrency'] = nameCurrency;
    data['price'] = price;
    data['course'] = course;
    data['multiplicity'] = multiplicity;
    return data;
  }
}

/// Остатки номенклатуры
class AccumProductRest {
  String uidWarehouse = '';
  String nameWarehouse = '';
  String uidProduct = '';
  String uidProductCharacteristic = '';
  String uidUnit = '';
  double rest = 0.0;
  double transit = 0.0;
  double reserved = 0.0;
  double freeRest = 0.0;

  AccumProductRest();

  AccumProductRest.fromJson(Map<String, dynamic> json) {
    uidWarehouse = json["uidWarehouse"] ?? '';
    nameWarehouse = json["nameWarehouse"] ?? '';
    uidProduct = json["uidProduct"] ?? '';
    uidProductCharacteristic = json["uidProductCharacteristic"] ?? '';
    uidUnit = json["uidUnit"] ?? '';
    rest = double.parse(json["rest"].toString());
    transit = double.parse(json["transit"].toString());
    reserved = double.parse(json["reserved"].toString());
    freeRest = double.parse(json["freeRest"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uidWarehouse'] = uidWarehouse;
    data['nameWarehouse'] = nameWarehouse;
    data['uidProduct'] = uidProduct;
    data['uidProductCharacteristic'] = uidProductCharacteristic;
    data['uidUnit'] = uidUnit;
    data['rest'] = rest;
    data['transit'] = transit;
    data['reserved'] = reserved;
    data['freeRest'] = freeRest;
    return data;
  }
}
