import 'package:client/homepage.dart';
import 'package:client/serverconnectpage.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'registrationpage.dart';
import 'chat.dart';
import 'settingspage.dart';

void main() {
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
        '/serverconnect': (context) => const Serverconnectpage()
      },
    );
  }
}
