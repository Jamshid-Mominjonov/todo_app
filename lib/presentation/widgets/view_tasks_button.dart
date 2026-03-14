import 'package:flutter/material.dart';

class ViewTasksButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ViewTasksButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}