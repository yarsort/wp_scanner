import 'package:flutter/material.dart';
import 'package:wp_scanner/system/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(5, 130, 202, .1),
      100: const Color.fromRGBO(5, 130, 202, .2),
      200: const Color.fromRGBO(5, 130, 202, .3),
      300: const Color.fromRGBO(5, 130, 202, .4),
      400: const Color.fromRGBO(5, 130, 202, .5),
      500: const Color.fromRGBO(5, 130, 202, .6),
      600: const Color.fromRGBO(5, 130, 202, .7),
      700: const Color.fromRGBO(5, 130, 202, .8),
      800: const Color.fromRGBO(5, 130, 202, .9),
      900: const Color.fromRGBO(5, 130, 202, 1),
    };

    MaterialColor colorApp = MaterialColor(0xFF0582CA, color);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WP Scanner',
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'ACDisplay',
        primarySwatch: colorApp,
      ),
      home: const ScreenSplashScreen(),
    );
  }
}
