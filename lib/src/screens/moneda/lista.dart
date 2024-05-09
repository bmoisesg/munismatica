import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/agregar.dart';

class PageMonedaLista extends StatefulWidget {
  final String idCategoria;
  final String nombreCategoria;
  const PageMonedaLista({required this.idCategoria, required this.nombreCategoria, super.key});

  @override
  State<PageMonedaLista> createState() => _PageMonedaListaState();
}

class _PageMonedaListaState extends State<PageMonedaLista> {
  List lista = [];

  Future<dynamic> getData() async {
    lista = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('moneda/${widget.idCategoria}/elementos').get();

    if (snapshot.exists) {
      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> dataMap = snapshot.value as Map;

        dataMap.forEach((key, value) {
          lista.add({
            "id": key,
            "data": value['año']!,
          });
        });
      }
      setState(() {});
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monedas - ${widget.nombreCategoria}'),
        elevation: 30,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: CustomButton(
              title: lista[index]['data'],
              fnt: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var pantalla = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageAgregar(
                      idCategoria: widget.idCategoria,
                    )),
          );
          getData();
        },
      ),
    );
  }
}
