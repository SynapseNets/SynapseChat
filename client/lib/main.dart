import 'dart:io';
import 'dart:async';

import 'package:client/chat/conversation.dart';
import 'package:client/settings/credits/developerscredits.dart';
import 'package:client/settings/credits/iconscredits.dart';
import 'package:client/settings/creditspage.dart';
import 'package:client/utils/db.dart';
import 'package:client/utils/encrypt.dart';
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

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:client/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!(Platform.isAndroid || Platform.isIOS)) {
    await windowManager.ensureInitialized();
    await WindowManager.instance.setMinimumSize(const Size(450, 800));

    WindowManager.instance.addListener(MyWindowListener());

    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Setup Database
  await getDb();

  runApp(const SynapseNetsApp());
}

class MyWindowListener extends WindowListener {
  //TODO: fix android version
  @override
  void onWindowClose() async {
    debugPrint('Window closed');
    if(File(await Cryptography.getDatabaseFile()).existsSync()){
      debugPrint('encrypting file');
      await Cryptography().encryptFile();
      debugPrint('encryped file');
    }
    await WindowManager.instance.destroy();
  }
}

class SynapseNetsApp extends StatefulWidget {
  const SynapseNetsApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) async {
    _SynapseNetsAppState? state =
        context.findAncestorStateOfType<_SynapseNetsAppState>();
    state!.changeLanguage(newLocale);
  }

  @override
  State<SynapseNetsApp> createState() => _SynapseNetsAppState();
}

class _SynapseNetsAppState extends State<SynapseNetsApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

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
      },
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('it'), // Italian
      ],
    );
  }
}
