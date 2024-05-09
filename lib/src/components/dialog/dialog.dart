import 'package:flutter/material.dart';

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
}
