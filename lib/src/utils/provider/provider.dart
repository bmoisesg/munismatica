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
  MonedaModel get listaMonedaFirst => listaMonedas.first;
  MonedaModel get listaMonedaLast => listaMonedas.last;

  Map<int, List<MonedaModel>> get summaryMonedas {
    if (listaMonedas.isEmpty) return {};
    final mapa = <int, List<MonedaModel>>{};
    final anios = listaMonedas.map((e) => int.parse(e.anio));
    final min = anios.reduce((a, b) => a < b ? a : b);
    final max = anios.reduce((a, b) => a > b ? a : b);
    for (int i = min; i <= max; i++) {
      mapa[i] = [];
    }
    for (var item in listaMonedas) {
      mapa[int.parse(item.anio)]!.add(item);
    }
    return mapa;
  }

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
