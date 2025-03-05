import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/appbar.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/model/moneda_model.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';
import 'package:provider/provider.dart';

class PageMonedaLista extends StatefulWidget {
  const PageMonedaLista({super.key});

  @override
  State<PageMonedaLista> createState() => _PageMonedaListaState();
}

class _PageMonedaListaState extends State<PageMonedaLista> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    List<MonedaModel> lista = provider.listaMonedas;
    Map<String, int> resumen = {};

    for (var moneda in lista) {
      resumen[moneda.anio] = (resumen[moneda.anio] ?? 0) + 1;
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Monedas - ${provider.nombreCategoria}',
        actions: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            List<bool> listpress = [];
            for (var element in resumen.values) {
              listpress.add(false);
            }
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) => Container(
                    padding: const EdgeInsets.all(15),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Año',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Cantidad',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...resumen.entries.toList().asMap().entries.map((e) {
                            int index = e.key;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  listpress[index] = !listpress[index];
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(color: listpress[index] ? Colors.grey[300] : Colors.white),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e.value.key,
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        e.value.value.toString(),
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('${lista.length} Monedas'),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 2 / 1),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(context, '/moneda_agregar');
        },
      ),
    );
  }
}
