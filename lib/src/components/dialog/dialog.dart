import 'package:flutter/material.dart';
import 'dart:io';

class CustomDialog {
  static Future show({
    required BuildContext context,
    required String contenido,
    String? title,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? 'Mensaje'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
          content: Text(contenido),
        );
      },
    );
  }

  static Future<void> fntAdvertenciaExitApp(
    bool bool,
    BuildContext context,
  ) {
    return showDialog(
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
  }

  static Future yesOrNot({
    required BuildContext context,
    required Function fntCancel,
    required Function fntOk,
    required String content,
    String titleOk = 'Si',
    String titleCancel = 'Cancel',
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          actions: [
            TextButton(
              child: Text(titleCancel),
              onPressed: () => fntCancel(),
            ),
            TextButton(
              child: Text(titleOk),
              onPressed: () => fntOk(),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content),
            ],
          ),
        );
      },
    );
  }

  static Future content({
    required BuildContext context,
    required Widget contenido,
  }) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: contenido,
        );
      },
    );
  }
}
