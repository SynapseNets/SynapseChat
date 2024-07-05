import 'package:flutter/material.dart';

class GraphicMessages{
  static normalMessage(String text, Color color, TextStyle style){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Wrap(children: [
        Text(text, style: style,)
      ],)
    );
  }
}