import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Function fnt;
  final Icon? icon;
  const CustomButton({required this.title, required this.fnt, this.icon, super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        shadowColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            bottomRight: Radius.circular(1),
          ),
        ),
      ),
      onPressed: () => widget.fnt(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon ?? Container(),
          Text(widget.title),
        ],
      ),
    );
  }
}
