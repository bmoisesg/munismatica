import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/screens/billete/billete_agregar.dart';
import 'package:mi_primera_numismatica/src/screens/billete/billete.dart';
import 'package:mi_primera_numismatica/src/screens/billete/billete_lista.dart';
import 'package:mi_primera_numismatica/src/screens/home.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/moneda_agregar.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/moneda_lista.dart';
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
        return MaterialPageRoute(builder: (_) => const PageBilleteAgregar());
      case '/moneda_lista':
        return MaterialPageRoute(builder: (_) => const PageMonedaLista());
      case '/moneda_agregar':
        return MaterialPageRoute(builder: (_) => const PageMonedaAgregar());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
