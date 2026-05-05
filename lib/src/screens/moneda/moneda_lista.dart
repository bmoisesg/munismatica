import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/appbar.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/components/dialog/dialog.dart';
import 'package:mi_primera_numismatica/src/model/moneda_model.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';
import 'package:provider/provider.dart';

class MonedaScreen extends StatefulWidget {
  const MonedaScreen({super.key});

  @override
  State<MonedaScreen> createState() => _MonedaScreenState();
}

class _MonedaScreenState extends State<MonedaScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    final String nombreCategoria = provider.nombreCategoria;
    final bool isloading = provider.isLoading;
    List<MonedaModel> listaMonedas = provider.listaMonedas;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          provider.cleanListaMonedas();
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(title: 'Monedas - $nombreCategoria'),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${listaMonedas.length} Moneda(s)',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2 / 1,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: listaMonedas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final moneda = listaMonedas[index];
                        return Stack(
                          children: [
                            CustomButton(title: moneda.anio, fnt: () {}),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Color.fromARGB(255, 213, 212, 212)),
                                  padding: EdgeInsets.zero,
                                  onPressed: () => fntDeleteMoneda(moneda.id),
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
            if (isloading) const Center(child: CircularProgressIndicator())
          ],
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

  Future fntDeleteMoneda(String idMoneda) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final String idCategoriaSelected = provider.idCategoria;

    CustomDialog.yesOrNot(
      context: context,
      content: '¿Deseas eliminar esta moneda?',
      fntOk: () async {
        final result = await MonedaService().deleteMoneda(idCategoriaSelected, idMoneda);
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado con exito')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para eliminar ')));
        }
        Navigator.pop(context);
      },
      fntCancel: () => Navigator.pop(context),
    );
  }
}
