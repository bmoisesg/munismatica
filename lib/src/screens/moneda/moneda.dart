import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/screens/moneda/lista.dart';

class PageMoneda extends StatefulWidget {
  const PageMoneda({super.key});

  @override
  State<PageMoneda> createState() => _PageMonedaState();
}

class _PageMonedaState extends State<PageMoneda> {
  Future<dynamic> getData() async {
    List lista = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('moneda/').get();
    if (snapshot.exists) {
      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> dataMap = snapshot.value as Map;
        dataMap.forEach((key, value) {
          lista.add({"id": key, "categoria": value['categoria']});
        });
        return lista;
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _ctrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monedas'),
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
                      try {
                        if (_ctrl.text == "") return;
                        DatabaseReference ref = FirebaseDatabase.instance.ref();

                        var data = {"categoria": _ctrl.text};
                        await ref.child('moneda').push().set(data);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Categoria agregada!')));
                        setState(() {});
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error para agregar categoria')));
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
                      controller: _ctrl,
                      decoration: InputDecoration(
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
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CustomButton(
                          title: snapshot.data![index]['categoria'] ?? "--",
                          fnt: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageMonedaLista(
                                  idCategoria: snapshot.data![index]['id']!,
                                  nombreCategoria: snapshot.data![index]['categoria']!,
                                ),
                              ),
                            );
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
