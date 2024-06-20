import 'package:flutter/material.dart';

class Brain_Stroke_Service extends StatelessWidget {
  const Brain_Stroke_Service({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Brain Stroke Detection',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
