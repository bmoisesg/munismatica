import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/components/dialog/dialog.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';
import 'package:provider/provider.dart';

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
      onPopInvoked: (didPop) => CustomDialog.fntAdvertenciaExitApp(didPop, context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi primer numismatica'),
          elevation: 30,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CustomButton(
                  title: 'Monedas',
                  icon: const Icon(Icons.monetization_on),
                  fnt: fntButtonMoneda,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  title: 'Billetes',
                  icon: const Icon(Icons.payments),
                  fnt: fntButtonBillete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fntButtonMoneda() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    provider.getDataCategoriasMoneda();
    Navigator.pushNamed(context, '/moneda_categoria');
  }

  void fntButtonBillete() {
    Navigator.pushNamed(context, '/billete');
  }
}
