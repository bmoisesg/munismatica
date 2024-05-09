import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/components/dialog/dialog.dart';
import 'package:intl/intl.dart';

class PageAgregar extends StatefulWidget {
  final String idCategoria;
  const PageAgregar({required this.idCategoria, super.key});

  @override
  State<PageAgregar> createState() => _PageAgregarState();
}

class _PageAgregarState extends State<PageAgregar> {
  TextEditingController _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Elemento"),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _ctrl,
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
                    "año": _ctrl.text,
                    "fecha_ingreso": fechaIngreso,
                  };
                  await ref.child('moneda/${widget.idCategoria}/elementos').push().set(data);
                  await CustomDialog.show(context: context, contenido: 'Moneda agregada!');
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error para agregar ')));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
