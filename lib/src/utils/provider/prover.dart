import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _nombreCategoria = "";
  String get nombreCategoria => _nombreCategoria;
  void setNombreCategoria(String nombreNuevo) {
    _nombreCategoria = nombreNuevo;
    notifyListeners();
  }

  String _idCategoria = "";
  String get idCategoria => _idCategoria;
  void setIdCategoria(String categoria) {
    _idCategoria = categoria;
    notifyListeners();
  }
}
