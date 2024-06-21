import 'package:flutter/material.dart';

class ChatPreferencesPage extends StatefulWidget {
  const ChatPreferencesPage({super.key});

  @override
  State<ChatPreferencesPage> createState() => _ChatPreferencesPageState();
}

class _ChatPreferencesPageState extends State<ChatPreferencesPage> {
   double sizeChar = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Font Size',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  sizeChar.toInt().toString(),
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
            Slider(
              value: sizeChar,
              min: 15,
              max: 30,
              divisions: 15,
              label: sizeChar.toInt().toString(),
              onChanged: (double value) {
                setState(() {
                  sizeChar = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Sample Text',
              style: TextStyle(fontSize: sizeChar),
            ),
          ],
        ),
      ),
    );
  }
}