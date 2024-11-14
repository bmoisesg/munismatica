import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class BilleteService {
  Future getBilletes(String idCategoria) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('billete/$idCategoria/elementos').get();
    if (snapshot.value != null) return snapshot.value;
    return null;
  }

  Future getCategoriaBilletes() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('billete/').get();
    if (snapshot.value != null) return snapshot.value;
    return null;
  }

  Future setCategoriaBillete(String categoria) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      var data = {"categoria": categoria};
      await ref.child('billete').push().set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future setBillete(String anio, String idCategoria) async {
    try {
      DateTime now = DateTime.now();
      var fechaIngreso = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      var data = {
        "año": anio,
        "fecha_ingreso": fechaIngreso,
      };
      await ref.child('billete/$idCategoria/elementos').push().set(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
