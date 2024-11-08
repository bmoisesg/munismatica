import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';
import 'package:provider/provider.dart';

class PageMonedaLista extends StatefulWidget {
  const PageMonedaLista({super.key});

  @override
  State<PageMonedaLista> createState() => _PageMonedaListaState();
}

class _PageMonedaListaState extends State<PageMonedaLista> {
  Future<dynamic> getData(String idCategoria) async {
    List lista = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('moneda/$idCategoria/elementos').get();

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
      return lista;
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) => Scaffold(
        appBar: AppBar(
          title: Text('Monedas - ${provider.nombreCategoria}'),
          elevation: 30,
        ),
        body: FutureBuilder(
          future: getData(provider.idCategoria),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              final List lista = snapshot.data;
              return ListView.builder(
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
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            Navigator.pushNamed(context, '/moneda_agregar');

            // getData();
          },
        ),
      ),
    );
  }
}
