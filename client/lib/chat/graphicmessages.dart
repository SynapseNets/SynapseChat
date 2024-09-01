import 'package:flutter/material.dart';
import 'package:client/chat/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GraphicMessages {
  static Widget normalMessage(
      String text, Color color, TextStyle style, DateTime date, MessageStatus status,
      {double? width, double? height, BoxConstraints? constraints}) {
    return Container(
      width: width, // Imposta una larghezza fissa
      height: height, // Imposta un'altezza fissa
      constraints: const BoxConstraints(
        minWidth: 30, // Larghezza minima
        maxWidth: 200, // Larghezza massima
        minHeight: 20,  // Altezza minima
      ), // Imposta vincoli di larghezza e altezza
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: style,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${date.hour}:${date.minute}",
                style: const TextStyle(fontSize: 10, color: Color(0xffe5e5e5)),
              ),
              Builder(builder: (context) {
                switch (status) {
                  case MessageStatus.sent:
                    return const Icon(
                      FontAwesomeIcons.check,
                      size: 15,
                    );
                  case MessageStatus.delivered:
                    return const Icon(
                      FontAwesomeIcons.checkDouble,
                      size: 15,
                    );
                  case MessageStatus.seen:
                    return const Icon(
                      FontAwesomeIcons.checkDouble,
                      color: Colors.blue,
                      size: 15,
                    );
                  default:
                    return const SizedBox(); // Se status non è riconosciuto, restituisce uno spazio vuoto
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}
