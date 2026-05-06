import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_primera_numismatica/src/components/components.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';

class AgregarMonedaWidge extends StatefulWidget {
  const AgregarMonedaWidge({super.key});

  @override
  State<AgregarMonedaWidge> createState() => _AgregarMonedaWidgeState();
}

class _AgregarMonedaWidgeState extends State<AgregarMonedaWidge> {
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Agregar Moneda',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Divider(),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: ctrl,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Año de moneda",
            fillColor: Colors.transparent,
            filled: true,
            isDense: true,
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          title: 'Agregar',
          fnt: () => fntAgregarMoneda(context),
        )
      ],
    );
  }

  void fntAgregarMoneda(context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final resultado = await MonedaService().setMoneda(ctrl.text, provider.idCategoria);
    final getDataMonedasByIdCategory = provider.getDataMonedasByIdCategory;
    final idCategoria = provider.idCategoria;

    if (resultado) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agregado con exito')));
      getDataMonedasByIdCategory(idCategoria);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para agregar ')));
    }
  }
}
