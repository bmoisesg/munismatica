import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_primera_numismatica/src/components/components.dart';
import 'package:mi_primera_numismatica/src/model/model.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';

class CategoriaMonedaScreen extends StatefulWidget {
  const CategoriaMonedaScreen({super.key});

  @override
  State<CategoriaMonedaScreen> createState() => _CategoriaMonedaScreenState();
}

class _CategoriaMonedaScreenState extends State<CategoriaMonedaScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    final listaCategorias = provider.listaCategoriasMonedas;
    final isloading = provider.isLoading;

    return Scaffold(
      appBar: const CustomAppbar(title: 'Monedas Categorias'),
      floatingActionButton: FloatingActionButton(
        onPressed: fntAgregarCategoria,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemCount: listaCategorias.length,
              itemBuilder: (context, index) {
                final CategoriaModel categoria = listaCategorias[index];
                return CustomButton(
                  title: 'Categoria: ${categoria.titulo}',
                  fnt: () {
                    provider.updateIdCategory(categoria.id);
                    provider.updateNameCategory(categoria.titulo);
                    provider.getDataMonedasByIdCategory(categoria.id);
                    Navigator.pushNamed(context, '/moneda_lista');
                  },
                );
              },
            ),
          ),
          if (isloading) const Center(child: CircularProgressIndicator())
        ],
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
