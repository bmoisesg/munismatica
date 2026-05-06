import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/screens/home.dart';
import 'package:mi_primera_numismatica/src/screens/screens.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings url) {
    switch (url.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/moneda_categoria':
        return MaterialPageRoute(builder: (_) => const CategoriaMonedaScreen());
      case '/moneda_lista':
        return MaterialPageRoute(builder: (_) => const MonedaScreen());

      case '/billete':
        return MaterialPageRoute(builder: (_) => const PageBillete());
      case '/billete_lista':
        return MaterialPageRoute(builder: (_) => const PageBilleteLista());
      case '/billete_agregar':
        return MaterialPageRoute(builder: (_) => const PageBilleteAgregar());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
