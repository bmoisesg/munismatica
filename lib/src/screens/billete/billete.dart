// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';
import 'package:mi_primera_numismatica/src/utils/services/billete_service.dart';
import 'package:provider/provider.dart';

class PageBillete extends StatefulWidget {
  const PageBillete({super.key});

  @override
  State<PageBillete> createState() => _PageBilleteState();
}

class _PageBilleteState extends State<PageBillete> {
  Future<dynamic> getData() async {
    List lista = [];
    final response = await BilleteService().getCategoriaBilletes();
    if (response != null) {
      response.forEach((key, value) {
        lista.add({"id": key, "categoria": value['categoria']});
      });
      return lista;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billetes'),
        elevation: 30,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          showDialog(
            //barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Agregar categoria"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (ctrl.text == "") return;
                      final response = await BilleteService().setCategoriaBillete(ctrl.text);
                      Navigator.pop(context);
                      if (response) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Categoria agregada!')));
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para agregar categoria')));
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: ctrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nombre",
                        fillColor: Colors.transparent,
                        filled: true,
                        isDense: true,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text('Categorias'),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CustomButton(
                          title: snapshot.data![index]['categoria'] ?? "--",
                          fnt: () {
                            final provider = Provider.of<AppProvider>(context, listen: false);
                            provider.setIdCategoria(snapshot.data![index]['id']!);
                            provider.setNombreCategoria(snapshot.data![index]['categoria']!);
                            Navigator.pushNamed(context, '/billete_lista');
                          },
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
