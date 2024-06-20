import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrainTumorService extends StatelessWidget {
  const BrainTumorService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Brain Tumor Detection',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
