import 'package:mi_primera_numismatica/src/components/appbar.dart';
import 'package:mi_primera_numismatica/src/model/billete_model.dart';
import 'package:mi_primera_numismatica/src/utils/services/billete_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';

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
        lista.add(BilleteModel.fromMap(value, key));
      });

      return lista;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) => Scaffold(
        appBar: CustomAppbar(title: 'Billete - ${provider.nombreCategoria}'),
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
                                          final result = await BilleteService().deleteBillete(provider.idCategoria, lista[index].id);
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
