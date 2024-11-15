import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/appbar.dart';
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
        lista.add(MonedaModel.fromMap(value, key));
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
        appBar: CustomAppbar(title: 'Monedas - ${provider.nombreCategoria}'),
        body: FutureBuilder<List<MonedaModel>>(
          future: getData(provider.idCategoria),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<MonedaModel> lista = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        CustomButton(
                          title: lista[index].anio,
                          fnt: () {},
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Mensaje'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          child: const Text('Si, eliminar'),
                                          onPressed: () async {
                                            final result = await MonedaService().deleteMoneda(provider.idCategoria, lista[index].id);
                                            if (result) {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado con exito')));
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para eliminar ')));
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                      content: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("¿Deseas eliminar este registro?"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.delete_outline, color: Color.fromARGB(255, 213, 212, 212)),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
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
