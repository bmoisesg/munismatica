import 'package:flutter/material.dart';

class PageBillete extends StatefulWidget {
  const PageBillete({super.key});

  @override
  State<PageBillete> createState() => _PageBilleteState();
}

class _PageBilleteState extends State<PageBillete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billetes'),
        elevation: 30,
      ),
    );
  }
}
