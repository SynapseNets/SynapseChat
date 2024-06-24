import 'package:flutter/material.dart';

class Iconscredits extends StatefulWidget {
  const Iconscredits({super.key});

  @override
  State<Iconscredits> createState() => _IconscreditsState();
}

class _IconscreditsState extends State<Iconscredits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Icons credits',
          style: TextStyle(
              color: const Color(0xff3b28cc),
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
