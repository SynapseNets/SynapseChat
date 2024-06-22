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
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: 250, // Imposta l'altezza massima desiderata
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 134, 120, 235), // Colore di sfondo all'interno del contorno
                    border: Border.all(
                      color: Colors.grey,
                      width: 3, // Spessore del contorno
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff1b2a41),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Hi there!',
                            style: TextStyle(fontSize: sizeChar),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff3b28cc),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Hello! How are you?',
                            style: TextStyle(fontSize: sizeChar),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff1b2a41),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'I\'m good, thanks! And you?',
                            style: TextStyle(fontSize: sizeChar),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
