import 'package:flutter/material.dart';

class ShopPageWidget extends StatelessWidget {
  const ShopPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text(
        'ShopPageWidget',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}