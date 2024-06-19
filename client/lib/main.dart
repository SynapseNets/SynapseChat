import 'package:client/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SynapseNetsApp());
}

class SynapseNetsApp extends StatelessWidget {
  const SynapseNetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      home: const SynapseNetsAppHomepage(),
    );
  }
}