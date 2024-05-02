import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:wp_scanner/controllers/api_controller.dart';
import 'package:wp_scanner/controllers/product_controller.dart';
import 'package:wp_scanner/db/db_ref_product.dart';
import 'package:wp_scanner/models/ref_product.dart';
import 'package:wp_scanner/system/system.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({Key? key}) : super(key: key);

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  DateTime currentBackPressTime = DateTime.now();

  /// Системные переменные
  bool loadingData = false;
  late bool visible;

  double heightScreen = 0;
  double widthScreen = 0;
  double widthDrawer = 70;

  bool validateSearch = false;

  Product product = Product();
  String urlPicture = '';
  String pathPicture = '';

  List<ProductCharacteristic> listCharacteristics = [];
  List<ProductProperty> listProperties = [];
  List<ProductImage> listImages = [];
  List<AccumProductRest> listRests = [];
  List<AccumProductPrice> listPrices = [];

  TextEditingController textFieldSearchCatalogController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: const Key('visible-detector-key-home-screen'),
          child: BarcodeKeyboardListener(
            onBarcodeScanned: (barcode) {
              if (!visible) return;
              setState(() {
                debugPrint('Scanned: $barcode');
                if (barcode == '') {
                  showErrorMessage('Порожній штрихкод товара!', context);
                  return;
                }
                _findProduct(barcode);
              });
            },
            child: SingleChildScrollView(
              child: Center(
                child: Row(
                  children: [
                    Container(
                      width: widthDrawer,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(right: BorderSide(color: Colors.black12)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(color: Colors.black12)),
                            ),
                            child: IconButton(onPressed: () {}, icon: const Icon(Icons.home_outlined)),
                          ),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.add_chart)),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - widthDrawer,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(color: Colors.black12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: TextField(
                                      onSubmitted: (String value) async {},
                                      controller: textFieldSearchCatalogController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        border: const OutlineInputBorder(),
                                        labelStyle: const TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                        labelText: 'Пошук',
                                        errorText: validateSearch ? 'Ви не вказали строку пошуку!' : null,
                                        //prefixIcon: const Icon(Icons.search),
                                        suffixIcon: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                _findProduct('3660310110020');
                                              },
                                              icon: const Icon(Icons.search, color: Colors.blue),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                //scanBarcodeNormal();
                                              },
                                              icon: const Icon(Icons.qr_code_scanner, color: Colors.blue),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                textFieldSearchCatalogController.text = '';
                                              },
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 85,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(product.name, style: const TextStyle(fontSize: 20)),
                                              ],
                                            )),
                                        const SizedBox(height: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Характеристика',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Склад',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Залишок',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Резерв',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Транзит',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Вільний залишок',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  Expanded(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: BouncingScrollPhysics(),
                                                        itemCount: listRests.length,
                                                        itemBuilder: (context, index) {
                                                          var item = listRests[index];

                                                          var indexItemCharacteristics = listCharacteristics.indexWhere(
                                                              (element) =>
                                                                  element.uid == item.uidProductCharacteristic);
                                                          var itemCharacteristic =
                                                              listCharacteristics[indexItemCharacteristics];

                                                          return Row(
                                                            children: [
                                                              Expanded(flex: 1, child: Text(itemCharacteristic.name)),
                                                              Expanded(flex: 1, child: Text(item.nameWarehouse)),
                                                              Expanded(
                                                                  flex: 1, child: Text(doubleThreeToString(item.rest))),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(doubleThreeToString(item.reserved))),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(doubleThreeToString(item.transit))),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(doubleThreeToString(item.freeRest))),
                                                            ],
                                                          );
                                                        }),
                                                  )
                                                ],
                                              )),
                                        ),
                                        const SizedBox(height: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Характеристика',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Тип ціни',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Ціна',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Валюта',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Курс',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Кратність',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          )),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  Expanded(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: listPrices.length,
                                                        itemBuilder: (context, index) {
                                                          var item = listPrices[index];

                                                          var indexItemCharacteristics = listCharacteristics.indexWhere(
                                                              (element) =>
                                                                  element.uid == item.uidProductCharacteristic);
                                                          var itemCharacteristic =
                                                              listCharacteristics[indexItemCharacteristics];

                                                          return Row(
                                                            children: [
                                                              Expanded(flex: 1, child: Text(itemCharacteristic.name)),
                                                              Expanded(flex: 1, child: Text(item.namePrice)),
                                                              Expanded(
                                                                  flex: 1, child: Text(doubleToString(item.price))),
                                                              Expanded(flex: 1, child: Text(item.nameCurrency)),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(doubleThreeToString(item.course))),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(doubleThreeToString(item.multiplicity))),
                                                            ],
                                                          );
                                                        }),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Характеристики:',
                                                    style: TextStyle(fontSize: 16), textAlign: TextAlign.left),
                                                const Divider(),
                                                Expanded(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const BouncingScrollPhysics(),
                                                      itemCount: listCharacteristics.length,
                                                      itemBuilder: (context, index) {
                                                        var item = listCharacteristics[index];
                                                        return Text('${item.name} - ${item.vendorCode}');
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Властивості:',
                                                    style: TextStyle(fontSize: 16), textAlign: TextAlign.left),
                                                const Divider(),
                                                Expanded(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const BouncingScrollPhysics(),
                                                      itemCount: listProperties.length,
                                                      itemBuilder: (context, index) {
                                                        var propertyItem = listProperties[index];
                                                        return Text(
                                                            '${propertyItem.nameValue}: ${propertyItem.uidValue}');
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Опис:',
                                                    style: TextStyle(fontSize: 16), textAlign: TextAlign.left),
                                                const Divider(),
                                                Expanded(
                                                  child: Text(product.description),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _findProduct(scannedValue) async {
    /// Штрихкоди формата EAN13 - це товари, а більшої довжини то посилання на комірки
    if (scannedValue.contains('-')) {
      await _addSellProductsByBarcode(scannedValue);
    } else {
      await _addProductByBarcode(scannedValue);
    }

    setState(() {});
  }

  _addProductByBarcode(productBarcode) async {
    listProperties.clear();
    listCharacteristics.clear();
    listImages.clear();
    listPrices.clear();
    listRests.clear();

    Product productScanned = await dbReadProductByBarcodeFromWeb(productBarcode);

    if (productScanned.uid.isEmpty) {
      if (!mounted) return;
      showErrorMessage('Товар по штрихкоду не знайдено!', context);
      FlutterBeep.beep(false);
      return;
    }

    FlutterBeep.beep();

    product = productScanned;

    /// Сохраним штрихкод для более быстрого сканирования
    product.barcode = productBarcode;

    listProperties.addAll(product.properties);
    listCharacteristics.addAll(product.characteristics);
    listImages.addAll(product.images);
    listPrices.addAll(product.prices);
    listRests.addAll(product.rests);

    /// Добавим остатки характеристик
    for (var item in product.characteristics) {
      for (var itemRest in item.rests) {
        listRests.add(itemRest);
      }
    }

    /// Добавим цены характеристик
    for (var item in product.characteristics) {
      for (var itemPrice in item.prices) {
        listPrices.add(itemPrice);
      }
    }
  }

  _addSellProductsByBarcode(sellBarcode) async {
    FlutterBeep.beep();
  }

  _getProductPictures() async {
    urlPicture = '$pathPicture/image?uidFile=${product.picture}';
    listImages.clear();

    // Request to server
    ApiResponse response = await getProductPictures(product.uid);

    // Read response
    if (response.error == null) {
      for (var item in response.data as List<dynamic>) {
        listImages.add(item);
      }
    } else if (response.error == unauthorized) {
      return;
    } else {
      showErrorMessage('${response.error}', context);
      return;
    }

    setState(() {});
  }
}
