import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/screens/billete/agregar.dart';
import 'package:mi_primera_numismatica/src/screens/billete/billete.dart';
import 'package:mi_primera_numismatica/src/screens/billete/lista.dart';
import 'package:mi_primera_numismatica/src/screens/home.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/agregar.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/lista.dart';
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
      case '/billete_lista':
        return MaterialPageRoute(builder: (_) => const PageBilleteLista());
      case '/billete_agregar':
        return MaterialPageRoute(builder: (_) => const PageAgregarBillete());
      case '/moneda_lista':
        return MaterialPageRoute(builder: (_) => const PageMonedaLista());
      case '/moneda_agregar':
        return MaterialPageRoute(builder: (_) => const PageAgregar());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
