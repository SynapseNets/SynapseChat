import 'package:flutter/material.dart';

class Developerscredits extends StatefulWidget {
  const Developerscredits({super.key});

  @override
  State<Developerscredits> createState() => _DeveloperscreditsState();
}

class _DeveloperscreditsState extends State<Developerscredits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Developers credits',
          style: TextStyle(
              color: const Color(0xff3b28cc),
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
