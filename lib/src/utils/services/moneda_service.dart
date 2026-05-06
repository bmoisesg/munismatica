import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mi_primera_numismatica/src/model/model.dart';

class MonedaService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<List<CategoriaModel>> getCategoriasMonedas() async {
    DataSnapshot snapshot = await ref.child('moneda/').get();
    if (snapshot.value == null) return [];
    final data = snapshot.value as Map<dynamic, dynamic>;
    return data.entries.map((e) => CategoriaModel.fromMap(e.value, e.key)).toList();
  }

  Future<List<MonedaModel>> getMonedas(String idCategoria) async {
    DataSnapshot snapshot = await ref.child('moneda/$idCategoria/elementos').get();
    if (snapshot.value == null) return [];
    final data = snapshot.value as Map<dynamic, dynamic>;
    return data.entries.map((e) => MonedaModel.fromMap(e.value, e.key)).toList();
  }

  Future<bool> setCategoriaMoneda(String categoria) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      var data = {"categoria": categoria};
      await ref.child('moneda').push().set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCategoriaMoneda(String idCategoria) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      await ref.child('moneda/$idCategoria').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setMoneda(String anio, String idCategoria) async {
    try {
      DateTime now = DateTime.now();
      var fechaIngreso = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      var data = {
        "año": anio,
        "fecha_ingreso": fechaIngreso,
      };
      await ref.child('moneda/$idCategoria/elementos').push().set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMoneda(String idCategoria, String idMoneda) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      await ref.child('moneda/$idCategoria/elementos/$idMoneda').remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
