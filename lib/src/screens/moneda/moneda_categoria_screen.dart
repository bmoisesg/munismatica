import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/agregar_moneda_categoria_widget.dart';
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
        onPressed: () => fntAgregarCategoria(context),
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

                return Stack(
                  children: [
                    CustomButton(
                      title: 'Categoria: ${categoria.titulo}',
                      fnt: () {
                        provider.updateIdCategory(categoria.id);
                        provider.updateNameCategory(categoria.titulo);
                        provider.getDataMonedasByIdCategory(categoria.id);
                        Navigator.pushNamed(context, '/moneda_lista');
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Color.fromARGB(255, 213, 212, 212)),
                          padding: EdgeInsets.zero,
                          onPressed: () => fntDeleteCategoria(categoria.id),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          if (isloading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  Future fntDeleteCategoria(String idCategoria) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final getDataCategoriasMoneda = provider.getDataCategoriasMoneda;

    CustomDialog.yesOrNot(
      context: context,
      content: '¿Deseas eliminar esta categoria?',
      fntOk: () async {
        final bool result = await MonedaService().deleteCategoriaMoneda(idCategoria);
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado con exito')));
          getDataCategoriasMoneda();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para eliminar ')));
        }
        Navigator.pop(context);
      },
      fntCancel: () => Navigator.pop(context),
    );
  }

  Future fntAgregarCategoria(context) async {
    CustomDialog.content(context: context, contenido: const AgregarMonedaCategoriaWidget());
  }
}
