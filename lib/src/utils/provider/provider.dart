import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/model/model.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';

class AppProvider extends ChangeNotifier {
  List<CategoriaModel> listaCategoriasMonedas = [];
  List<MonedaModel> listaMonedas = [];
  bool isLoading = false;
  String _nombreCategoria = "";
  String _idCategoria = "";
  String get nombreCategoria => _nombreCategoria;
  String get idCategoria => _idCategoria;

  Future getDataCategoriasMoneda() async {
    isLoading = true;
    notifyListeners();
    final List<CategoriaModel> response = await MonedaService().getCategoriasMonedas();
    listaCategoriasMonedas.clear();
    listaCategoriasMonedas.addAll(response);
    isLoading = false;
    notifyListeners();
  }

  void updateIdCategory(String newId) {
    _idCategoria = newId;
    notifyListeners();
  }

  void updateNameCategory(String newName) {
    _nombreCategoria = newName;
    notifyListeners();
  }

  Future getDataMonedasByIdCategory(String idCategoria) async {
    isLoading = true;
    notifyListeners();
    final List<MonedaModel> response = await MonedaService().getMonedas(idCategoria);
    listaMonedas.clear();
    listaMonedas.addAll(response);
    listaMonedas.sort((a, b) => a.anio.compareTo(b.anio));
    isLoading = false;
    notifyListeners();
  }

  void cleanListaMonedas() {
    listaMonedas.clear();
    notifyListeners();
  }
}
