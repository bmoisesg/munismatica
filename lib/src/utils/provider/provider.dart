import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/model/moneda_model.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';

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

  bool isLoading = false;
  List listaCategorias = [];

  void requestMoneda() {}

  Future<dynamic> getDataCategoria() async {
    isLoading = true;
    notifyListeners();
    final response = await MonedaService().getCategoriaMoneda();
    if (response != null) {
      listaCategorias = [];
      response.forEach((key, value) {
        listaCategorias.add({"id": key, "categoria": value['categoria']});
      });
      isLoading = false;
      notifyListeners();
      return listaCategorias;
    }
    isLoading = false;
    notifyListeners();
    return [];
  }

  List<MonedaModel> listaMonedas = [];

  Future<List<MonedaModel>> getDataMonedas(String idCategoria) async {
    isLoading = true;
    notifyListeners();
    final response = await MonedaService().getMonedas(idCategoria);

    if (response != null) {
      listaMonedas = [];
      response.forEach((key, value) {
        listaMonedas.add(MonedaModel.fromMap(value, key));
      });

      listaMonedas.sort((a, b) => a.anio.compareTo(b.anio));
      isLoading = false;
      notifyListeners();
      return listaMonedas;
    }
    isLoading = false;
    notifyListeners();
    return [];
  }
}
