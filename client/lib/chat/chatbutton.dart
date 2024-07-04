// chat_button.dart
import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String lastMessage;
  final String time;

  const ChatButton({
    super.key, 
    required this.title, 
    required this.onPressed, 
    required this.lastMessage, 
    required this.time
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Color.fromARGB(255, 233, 233, 233), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              lastMessage,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
