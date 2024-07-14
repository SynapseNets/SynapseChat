import 'dart:async';

import 'package:client/chat/message.dart';
import 'package:client/chat/conversation.dart';
import 'package:flutter/gestures.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDb() async {
  final database = await openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS messages(id AUTO_INCREMENT INTEGER PRIMARY KEY, text TEXT, type INTEGER, status INTEGER, sender TEXT, name TEXT, time TEXT, audio TEXT, image TEXT)'
          );
      db.execute(
          'CREATE TABLE IF NOT EXISTS conversations(id AUTO_INCREMENT INTEGER PRIMARY KEY, name TEXT)' //name = name
          );
      db.execute(
        'CREATE TABLE IF NOT EXISTS servers(id AUTO_INCREMENT INTEGER PRIMARY KEY, ip TEXT, port INTEGER, username TEXT, totp_uri TEXT)',
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

Future<List<Message>> retrieveMessage(String name) async {
  final db = await getDb();

  final List<Map<String, Object?>> messages = await db.query(
    'messages',
    where: 'name = ?',
    whereArgs: [name],
  );

  List<Message> result = [];

  for (var message in messages) {
    result.add(Message(
      text: message['text'] as String,
      time: DateTime.parse(message['time'] as String),
      type: MessageType.values[message['type'] as int],
      sender: message['sender'] as String,
      name: message['name'] as String,
      audio: message['audio'] as String?,
    ));
  }

  return result;
}

Future<void> deleteChat(final String sender) async {
  final db = await getDb();

  await db.delete('messages', where: 'sender = ?', whereArgs: [sender]);
}

Future<void> deleteMessage(final DateTime time, final String sender) async {
  final db = await getDb();

  await db.delete('messages',
      where: 'sender = ? AND time = ?',
      whereArgs: [sender, time.toIso8601String()]);
}

Future<List<Conversation>> getConversations() async {
  final db = await getDb();

  List<Conversation> result = [];

  for (var conversation in await db.rawQuery('SELECT name FROM conversations')) {

    Message lastMessage;
    try{
      lastMessage = (await retrieveMessage(conversation['name'] as String)).last;
    } catch (e) {
      lastMessage = Message(text: 'This is the start of the conversation', time: DateTime.now(), type: MessageType.text, sender: 'me', name: conversation['name'] as String);
    }

    DateTime time = lastMessage.time;

    result.add(Conversation(
      receiver: conversation['name'] as String,
      lastMessage: lastMessage.text,
      lastMessageTime: time,
    ));
  }

  print(result);
  result.sort((a, b) {
    return b.lastMessageTime.compareTo(a.lastMessageTime);
  });

  return result;
}

Future<void> insertConversation(Conversation conversation) async {
  final db = await getDb();

  await db.insert(
    'conversations',
    conversation.prepareDb(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<bool> addServer(String ip, int port, String username, String totpUri) async {
  final db = await getDb();

  var result = await db.query('servers', where: 'ip = ? AND port = ? AND username = ?', whereArgs: [ip, port, username]);
  if(result.isNotEmpty){
    return false;
  }

  await db.insert(
    'servers',
    {
      'ip':ip,
      'port':port,
      'username':username,
      'totp_uri':totpUri
    }
  );
  return true;
}
