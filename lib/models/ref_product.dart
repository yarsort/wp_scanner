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

  List<ProductCharacteristic> itemsProductCharacteristic = [];
  List<ProductProperty> itemsProductProperty = [];
  List<ProductImage> itemsProductImage = [];
  List<AccumProductPrice> itemsProductPrice = [];
  List<AccumProductRest> itemsProductRest = [];

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

    if (json['itemsProductCharacteristic'] != null) {
      itemsProductCharacteristic =
          List<dynamic>.from(json['itemsProductCharacteristic']).map((i) => ProductCharacteristic.fromJson(i)).toList();
    }
    if (json['itemsProductProperty'] != null) {
      itemsProductProperty =
          List<dynamic>.from(json['itemsProductProperty']).map((i) => ProductProperty.fromJson(i)).toList();
    }
    if (json['itemsProductImage'] != null) {
      itemsProductImage = List<dynamic>.from(json['itemsProductImage']).map((i) => ProductImage.fromJson(i)).toList();
    }
    if (json['itemsProductPrice'] != null) {
      itemsProductPrice =
          List<dynamic>.from(json['itemsProductPrice']).map((i) => AccumProductPrice.fromJson(i)).toList();
    }
    if (json['itemsProductRest'] != null) {
      itemsProductRest = List<dynamic>.from(json['itemsProductRest']).map((i) => AccumProductRest.fromJson(i)).toList();
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
    data['itemsProductCharacteristic'] = itemsProductCharacteristic.map((e) => e.toJson()).toList();
    data['itemsProductProperty'] = itemsProductProperty.map((e) => e.toJson()).toList();
    data['itemsProductImage'] = itemsProductImage.map((e) => e.toJson()).toList();
    data['itemsProductPrice'] = itemsProductPrice.map((e) => e.toJson()).toList();
    data['itemsProductRest'] = itemsProductRest.map((e) => e.toJson()).toList();
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

  ProductCharacteristic();

  ProductCharacteristic.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    code = json['code'] ?? '';
    vendorCode = json['vendorCode'] ?? '';
    name = json['name'] ?? '';
    uidProduct = json['uidProduct'] ?? '';
    barcode = json['barcode'] ?? '';
    comment = json['comment'] ?? '';
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
  double price = 0.0;

  AccumProductPrice();

  AccumProductPrice.fromJson(Map<String, dynamic> json) {
    uidPrice = json["uidPrice"] ?? '';
    namePrice = json["namePrice"] ?? '';
    uidProduct = json["uidProduct"] ?? '';
    uidProductCharacteristic = json["uidProductCharacteristic"] ?? '';
    uidUnit = json["uidUnit"] ?? '';
    price = double.parse(json["price"] ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uidPrice'] = uidPrice;
    data['namePrice'] = namePrice;
    data['uidProduct'] = uidProduct;
    data['uidProductCharacteristic'] = uidProductCharacteristic;
    data['uidUnit'] = uidUnit;
    data['price'] = price;
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
  double count = 0.0;

  AccumProductRest();

  AccumProductRest.fromJson(Map<String, dynamic> json) {
    uidWarehouse = json["uidWarehouse"] ?? '';
    nameWarehouse = json["nameWarehouse"] ?? '';
    uidProduct = json["uidProduct"] ?? '';
    uidProductCharacteristic = json["uidProductCharacteristic"] ?? '';
    uidUnit = json["uidUnit"] ?? '';
    count = double.parse(json["count"] ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uidWarehouse'] = uidWarehouse;
    data['nameWarehouse'] = nameWarehouse;
    data['uidProduct'] = uidProduct;
    data['uidProductCharacteristic'] = uidProductCharacteristic;
    data['uidUnit'] = uidUnit;
    data['count'] = count;
    return data;
  }
}
