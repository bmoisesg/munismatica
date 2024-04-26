import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi primer numismatica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 37, 80, 199)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
