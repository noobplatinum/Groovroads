import 'package:flutter/material.dart';

class EntryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final String title;

  const EntryButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 196, 154, 49), 
        minimumSize: Size(width ?? 300, height ?? 70), // Narrower and shorter size
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20, // Smaller text size
          fontWeight: FontWeight.w400, // Lighter font weight
        ),
      ),
    );
  }
}