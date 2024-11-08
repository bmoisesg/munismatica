import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/screens/billete/agregar.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';

class PageBilleteLista extends StatefulWidget {
  const PageBilleteLista({super.key});

  @override
  State<PageBilleteLista> createState() => _PageBilleteListaState();
}

class _PageBilleteListaState extends State<PageBilleteLista> {
  Future<dynamic> getData(String idCategoria) async {
    List lista = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('billete/$idCategoria/elementos').get();

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
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) => Scaffold(
        appBar: AppBar(
          // title: Text('Billete - ${provider.nombreCategoria}'),
          title: const Text('Billete'),
          elevation: 30,
        ),
        body: FutureBuilder(
          future: getData(provider.idCategoria),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              final lista = snapshot.data;
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
          onPressed: () {
            Navigator.pushNamed(context, '/billete_agregar');
            // getData();
          },
        ),
      ),
    );
  }
}
