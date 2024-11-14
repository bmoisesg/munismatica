// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/components/dialog/dialog.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';
import 'package:mi_primera_numismatica/src/utils/services/moneda_service.dart';
import 'package:provider/provider.dart';

class PageMonedaAgregar extends StatefulWidget {
  const PageMonedaAgregar({super.key});

  @override
  State<PageMonedaAgregar> createState() => _PageMonedaAgregarState();
}

class _PageMonedaAgregarState extends State<PageMonedaAgregar> {
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) => Scaffold(
        appBar: AppBar(
          title: const Text("Agregar Moneda"),
          elevation: 30,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ctrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "año",
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Agregar',
                fnt: () async {
                  final resultado = await MonedaService().setMoneda(ctrl.text, provider.idCategoria);
                  if (resultado) {
                    await CustomDialog.show(context: context, contenido: 'Moneda agregada!');
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error para agregar ')));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
