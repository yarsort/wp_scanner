import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wp_scanner/home.dart';
import 'package:wp_scanner/system/system.dart';

class ScreenSplashScreen extends StatefulWidget {
  const ScreenSplashScreen({Key? key}) : super(key: key);

  @override
  _ScreenSplashScreenState createState() => _ScreenSplashScreenState();
}

class _ScreenSplashScreenState extends State<ScreenSplashScreen> {
  bool visible = false;
  DateTime currentBackPressTime = DateTime.now();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();

    _initPackageInfo();
    initializeUser();
  }

  Future initializeUser() async {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScreenHomePage()), (Route<dynamic> route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final navigator = Navigator.of(context);
        bool backStatus = onWillPop();
        if (backStatus) {
          navigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/background_splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                const Text(
                  'WP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Scanner',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  'Інформаційне РМ \n для сканування товарів',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Text(
                  'TM Yarsoft. Version: ${_packageInfo.version}. Build:  ${_packageInfo.buildNumber}',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showMessage('Для виходу натисніть кнопку "Назад" ще раз.', context);
      return false;
    }
    return true;
  }

  cornerLogo() {
    return CircleAvatar(
      radius: 58,
      child: ClipOval(
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 114,
          width: 114,
        ),
      ),
    );
  }

  logo() {
    return Image.asset(
      'assets/app_logo.png',
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
  }
}
