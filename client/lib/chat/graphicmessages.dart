import 'package:flutter/material.dart';
import 'package:client/chat/message.dart';

class GraphicMessages{
  static normalMessage(String text, Color color, TextStyle style, DateTime date, MessageStatus status){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: style,),
          Text("${date.hour}:${date.minute}", style: const TextStyle(fontSize: 10, color: Color(0xffe5e5e5)), textAlign: TextAlign.left),
        ],)
    );
  }
}