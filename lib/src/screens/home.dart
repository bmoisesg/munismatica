import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Precaucion'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text('Si, salir'),
                ),
              ],
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("¿Estas seguro que quieres salir de la aplicacion?"),
                ],
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi primer numismatica'),
          elevation: 30,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CustomButton(
                  title: 'Monedas',
                  icon: const Icon(Icons.monetization_on),
                  fnt: () {
                    Navigator.pushNamed(context, '/moneda');
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  title: 'Billetes',
                  icon: const Icon(Icons.payments),
                  fnt: () {
                    Navigator.pushNamed(context, '/billete');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
