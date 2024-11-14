// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/appbar.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/components/dialog/dialog.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';
import 'package:mi_primera_numismatica/src/utils/services/billete_service.dart';
import 'package:provider/provider.dart';

class PageBilleteAgregar extends StatefulWidget {
  const PageBilleteAgregar({super.key});

  @override
  State<PageBilleteAgregar> createState() => _PageBilleteAgregarState();
}

class _PageBilleteAgregarState extends State<PageBilleteAgregar> {
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) => Scaffold(
        appBar: const CustomAppbar(title: "Agregar Billete"),
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
                  final resultado = await BilleteService().setBillete(ctrl.text, provider.idCategoria);
                  if (resultado) {
                    await CustomDialog.show(context: context, contenido: 'Billete agregado!');
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
