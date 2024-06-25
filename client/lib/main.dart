import 'dart:io';
import 'dart:async';

import 'package:client/chat/conversation.dart';
import 'package:client/settings/credits/developerscredits.dart';
import 'package:client/settings/credits/iconscredits.dart';
import 'package:client/settings/creditspage.dart';
import 'package:client/utils/db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:client/chat/message.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:client/homepage.dart';
import 'package:client/serverconnectpage.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'loginpage.dart';
import 'registrationpage.dart';
import 'chat.dart';
import 'settingspage.dart';
import 'settings/profileinfo.dart';
import 'settings/chat_preferences.dart';
import 'settings/languagespage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!(Platform.isAndroid || Platform.isIOS)) {
    await windowManager.ensureInitialized();
    await WindowManager.instance.setMinimumSize(const Size(450, 800));
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  //await insertMessage(Message(text: 'Hello', time: DateTime(2016, 3, 2, 13, 15, 27, 11, 100), type: MessageType.text, sender: 'not me'));
  //var result = await retrieveMessage('not me');
  //print(result[0]);

  runApp(const SynapseNetsApp());
}

class SynapseNetsApp extends StatelessWidget {
  const SynapseNetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigoAccent,
            brightness: Brightness.dark,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SynapseNetsAppHomepage(),
          '/login': (context) => const LoginPage(),
          '/registration': (context) => const Registrationpage(),
          '/chat': (context) => const Chat(),
          '/settings': (context) => const SettingsPage(),
          '/profileinfo': (context) => const Profileinfo(),
          '/serverconnect': (context) => const Serverconnectpage(),
          '/chatsettings': (context) => const ChatPreferencesPage(),
          '/languagesettings': (context) => const ChatLanguagesPage(),
          '/credits': (context) => const Creditspage(),
          '/developerscredits': (context) => const Developerscredits(),
          '/iconscredits': (context) => const Iconscredits(),
        });
  }
}
