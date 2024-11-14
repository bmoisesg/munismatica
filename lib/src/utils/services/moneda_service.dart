import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class MonedaService {
  Future getMonedas(String idCategoria) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('moneda/$idCategoria/elementos').get();
    if (snapshot.value != null) return snapshot.value;
    return null;
  }

  Future getCategoriaMoneda() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('moneda/').get();
    if (snapshot.value != null) return snapshot.value;
    return null;
  }

  Future setCategoriaMoneda(String categoria) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      var data = {"categoria": categoria};
      await ref.child('moneda').push().set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future setMoneda(String anio, String idCategoria) async {
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
}
