
import 'package:flutter/material.dart';

import 'controllers/planet_controller.dart';
import 'controllers/theme_controller.dart';
import 'views/screens/detail_page.dart';
import 'views/screens/home_page.dart';
import 'views/screens/splash_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => PlanetController(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeController(),
      ),
    ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const HomePage(),
        'splash_screen': (context) => const SplashScreen(),
        'detail_page': (context) => const DetailPage(),
      },
    );
  }
}
