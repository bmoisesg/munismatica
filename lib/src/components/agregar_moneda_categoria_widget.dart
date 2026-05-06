import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/components.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';
import 'package:provider/provider.dart';

class AgregarMonedaCategoriaWidget extends StatefulWidget {
  const AgregarMonedaCategoriaWidget({super.key});

  @override
  State<AgregarMonedaCategoriaWidget> createState() => _AgregarMonedaCategoriaWidgetState();
}

class _AgregarMonedaCategoriaWidgetState extends State<AgregarMonedaCategoriaWidget> {
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Agregar Categoria Moneda',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Divider(),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: ctrl,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nombre Categoria",
            fillColor: Colors.transparent,
            filled: true,
            isDense: true,
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          title: 'Agregar',
          fnt: () => fntAgregar(context),
        )
      ],
    );
  }

  Future fntAgregar(context) async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final getDataCategoriasMoneda = provider.getDataCategoriasMoneda;

    if (ctrl.text == "") return;
    final response = await MonedaService().setCategoriaMoneda(ctrl.text);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Categoria agregada!')));
      getDataCategoriasMoneda();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para agregar categoria')));
    }
  }
}
