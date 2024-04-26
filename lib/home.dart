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

  double widthDrawer = 70;

  bool validateSearch = false;

  Product product = Product();
  String urlPicture = '';
  String pathPicture = '';

  List<String> listProperties = [];
  List<ProductImage> listPictures = [];

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
                                        prefixIcon: const Icon(Icons.search),
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
                                  child: Container(
                                    child: ListView(
                                      children: [],
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
                                                const Text('Характиристики:',
                                                    style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: listProperties.length,
                                                    itemBuilder: (context, index) {
                                                      var propertyItem = listProperties[index];
                                                      return const ListTile(
                                                        title: Text('name'),
                                                      );
                                                    })
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
                                                    style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: listProperties.length,
                                                    itemBuilder: (context, index) {
                                                      var propertyItem = listProperties[index];
                                                      return const ListTile(
                                                        title: Text('name'),
                                                      );
                                                    })
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
                                                    style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: listProperties.length,
                                                    itemBuilder: (context, index) {
                                                      var propertyItem = listProperties[index];
                                                      return const ListTile(
                                                        title: Text('name'),
                                                      );
                                                    })
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
  }

  _addProductByBarcode(productBarcode) async {
    if (product.barcode != productBarcode) {
      Product productItem = await dbReadProductByBarcodeFromWeb(productBarcode);

      if (productItem.uid.isEmpty) {
        if (!mounted) return;
        showErrorMessage('Товар по штрихкоду не знайдено!', context);
        FlutterBeep.beep(false);
        return;
      }

      /// Если товар не такой как уже ранее был выбран, значит старый добавим как есть,
      /// а новый товар обновим на форме
      if (productItem.uid != product.uid) {
        return;
      }

      /// Сохраним штрихкод для более быстрого сканирования
      product.barcode = productBarcode;
    }

    FlutterBeep.beep();
  }

  _addSellProductsByBarcode(sellBarcode) async {
    FlutterBeep.beep();
  }

  _getProductPictures() async {
    urlPicture = '$pathPicture/image?uidFile=${product.picture}';
    listPictures.clear();

    // Request to server
    ApiResponse response = await getProductPictures(product.uid);

    // Read response
    if (response.error == null) {
      for (var item in response.data as List<dynamic>) {
        listPictures.add(item);
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
