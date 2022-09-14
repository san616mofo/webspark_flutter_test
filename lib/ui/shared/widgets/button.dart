import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isActive;
  final void Function() onPressed;

  const Button({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: isActive == true ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: Colors.cyanAccent,
          onPrimary: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
            side: BorderSide(
              color: Colors.blue[300]!,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
