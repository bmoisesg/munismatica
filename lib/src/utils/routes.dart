import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/screens/billete/billete.dart';
import 'package:mi_primera_numismatica/src/screens/home.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/moneda.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings url) {
    switch (url.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/moneda':
        return MaterialPageRoute(builder: (_) => const PageMoneda());
      case '/billete':
        return MaterialPageRoute(builder: (_) => const PageBillete());

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
