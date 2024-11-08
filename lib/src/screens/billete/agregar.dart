// ignore_for_file: use_build_context_synchronously

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/components/dialog/dialog.dart';
import 'package:intl/intl.dart';
import 'package:mi_primera_numismatica/src/utils/provider/prover.dart';
import 'package:provider/provider.dart';

class PageAgregarBillete extends StatefulWidget {
  const PageAgregarBillete({super.key});

  @override
  State<PageAgregarBillete> createState() => _PageAgregarBilleteState();
}

class _PageAgregarBilleteState extends State<PageAgregarBillete> {
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) => Scaffold(
        appBar: AppBar(
          title: const Text("Agregar Elemento"),
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
                  try {
                    DateTime now = DateTime.now();
                    var fechaIngreso = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                    DatabaseReference ref = FirebaseDatabase.instance.ref();
                    var data = {
                      "año": ctrl.text,
                      "fecha_ingreso": fechaIngreso,
                    };
                    await ref.child('billete/${provider.idCategoria}/elementos').push().set(data);
                    await CustomDialog.show(context: context, contenido: 'Billete agregado!');
                    Navigator.pop(context);
                  } catch (e) {
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
