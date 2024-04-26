import 'package:flutter/material.dart';

class PageMoneda extends StatefulWidget {
  const PageMoneda({super.key});

  @override
  State<PageMoneda> createState() => _PageMonedaState();
}

class _PageMonedaState extends State<PageMoneda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monedas'),
        elevation: 30,
      ),
    );
  }
}
