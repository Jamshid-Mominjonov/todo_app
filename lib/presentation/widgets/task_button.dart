import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TaskButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Color(0xff62D2C3),
      ),
      onPressed: onPressed,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}