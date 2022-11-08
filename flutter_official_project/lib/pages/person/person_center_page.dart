
import 'package:flutter/material.dart';

class PersonCenterPage extends StatelessWidget {
  const PersonCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text(
        'PersonCenter',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}