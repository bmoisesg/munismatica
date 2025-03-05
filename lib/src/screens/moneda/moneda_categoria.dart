// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/appbar.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';
import 'package:provider/provider.dart';

class PageMoneda extends StatefulWidget {
  const PageMoneda({super.key});

  @override
  State<PageMoneda> createState() => _PageMonedaState();
}

class _PageMonedaState extends State<PageMoneda> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    final listaCategorias = provider.listaCategorias;

    return Scaffold(
      appBar: const CustomAppbar(title: 'Moneda'),
      floatingActionButton: FloatingActionButton(
        onPressed: fntAgregarCategoria,
        child: const Icon(Icons.add),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text('Categorias'),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemCount: listaCategorias.length,
                      itemBuilder: (context, i) {
                        return CustomButton(
                          title: listaCategorias[i]['categoria'] ?? "--",
                          fnt: () {
                            provider.setIdCategoria(listaCategorias[i]['id']!);
                            provider.setNombreCategoria(listaCategorias[i]['categoria']!);
                            provider.getDataMonedas(listaCategorias[i]['id']!);
                            Navigator.pushNamed(context, '/moneda_lista');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  fntAgregarCategoria() async {
    TextEditingController ctrl = TextEditingController();
    showDialog(
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
                final response = await MonedaService().setCategoriaMoneda(ctrl.text);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Categoria agregada!')));
                  Navigator.pop(context);
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
  }
}
