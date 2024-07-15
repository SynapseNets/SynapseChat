// chat_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String lastMessage;
  final String time;
  final String profileImagePath;

  const ChatButton({
    super.key, 
    required this.title, 
    required this.onPressed, 
    required this.lastMessage, 
    required this.time,
    required this.profileImagePath
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Utilizza SvgPicture.asset per caricare le immagini SVG
                SvgPicture.asset(
                  profileImagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16), // Spazio tra l'immagine e il testo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 233, 233, 233),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4), // Spazio tra title e lastMessage
                      Text(
                        lastMessage,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8), // Spazio tra il testo e il tempo
                Text(
                  time,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
