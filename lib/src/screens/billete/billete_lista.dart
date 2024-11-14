import 'package:mi_primera_numismatica/src/model/billete_model.dart';
import 'package:mi_primera_numismatica/src/utils/services/billete_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';

class PageBilleteLista extends StatefulWidget {
  const PageBilleteLista({super.key});

  @override
  State<PageBilleteLista> createState() => _PageBilleteListaState();
}

class _PageBilleteListaState extends State<PageBilleteLista> {
  Future<List<BilleteModel>> getData(String idCategoria) async {
    List<BilleteModel> lista = [];
    final response = await BilleteService().getBilletes(idCategoria);

    if (response != null) {
      response.forEach((key, value) {
        lista.add(BilleteModel.fromMap(value));
      });

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
        body: FutureBuilder<List<BilleteModel>>(
          future: getData(provider.idCategoria),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<BilleteModel> lista = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: CustomButton(
                      title: lista[index].anio,
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
