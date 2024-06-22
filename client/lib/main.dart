import 'dart:io';
import 'dart:ui';

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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  windowManager.ensureInitialized();

  if(!(Platform.isAndroid || Platform.isIOS)) {
    WindowManager.instance.setMinimumSize(const Size(450, 800));
  }

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
        '/chatsettings': (context) => const ChatPreferencesPage()
      },
    );
  }
}
