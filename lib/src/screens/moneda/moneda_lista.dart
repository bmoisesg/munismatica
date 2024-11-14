import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/model/moneda_model.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';
import 'package:provider/provider.dart';

class PageMonedaLista extends StatefulWidget {
  const PageMonedaLista({super.key});

  @override
  State<PageMonedaLista> createState() => _PageMonedaListaState();
}

class _PageMonedaListaState extends State<PageMonedaLista> {
  Future<List<MonedaModel>> getData(String idCategoria) async {
    List<MonedaModel> lista = [];
    final response = await MonedaService().getMonedas(idCategoria);

    if (response != null) {
      response.forEach((key, value) {
        lista.add(MonedaModel.fromMap(value));
      });

      lista.sort((a, b) => a.anio.compareTo(b.anio));
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
        body: FutureBuilder<List<MonedaModel>>(
          future: getData(provider.idCategoria),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<MonedaModel> lista = snapshot.data!;
              return ListView.builder(
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
          onPressed: () async {
            Navigator.pushNamed(context, '/moneda_agregar');
          },
        ),
      ),
    );
  }
}
