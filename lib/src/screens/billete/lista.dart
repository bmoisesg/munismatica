import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';

class PageBilleteLista extends StatefulWidget {
  final String valor;
  const PageBilleteLista({required this.valor, super.key});

  @override
  State<PageBilleteLista> createState() => _PageBilleteListaState();
}

class _PageBilleteListaState extends State<PageBilleteLista> {
  List elementos = [
    "valor 1",
    "valor 2",
    "valor 3",
    "valor 4",
    "valor 4",
    "valor 4",
    "valor 4",
    "valor 4",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.valor),
        elevation: 30,
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: elementos.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: CustomButton(
                title: elementos[index],
                fnt: () {},
              ),
            );
          }),
    );
  }
}
