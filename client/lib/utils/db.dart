import 'dart:async';

import 'package:client/chat/message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDb() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE IF NOT EXISTS messages(id AUTO_INCREMENT INTEGER PRIMARY KEY, text TEXT, type INTEGER, status INTEGER, sender TEXT, time TEXT, audio TEXT, image TEXT)'
      );
    },
    version: 1,
  );

  return database;
}

Future<void> insertMessage(Message message) async {
  final db = await getDb();

  await db.insert(
    'messages',
    message.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Message>> retrieveMessage(String sender) async {
  final db = await getDb();

  final List<Map<String, Object?>> messages = await db.query(
    'messages',
    where: 'sender = ?',
    whereArgs: [sender],
  );

  List<Message> result = [];

  for (var message in messages){
    result.add(Message(
      text: message['text'] as String,
      time: DateTime.parse(message['time'] as String),
      type: MessageType.values[message['type'] as int],
      sender: message['sender'] as String,
      audio: message['audio'] as String?,
    ));
  }

  return result;
}

Future<void> deleteChat(final String sender) async {
  final db = await getDb();

  await db.delete(
    'messages',
    where: 'sender = ?',
    whereArgs: [sender]
    );
}

Future<void> deleteMessage(final DateTime time, final String sender) async {
  final db = await getDb();

  await db.delete(
    'messages',
    where: 'sender = ? AND time = ?',
    whereArgs: [sender, time.toIso8601String()]
    );
}