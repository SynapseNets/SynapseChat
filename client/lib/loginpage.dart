import 'dart:io';

import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:client/utils/encrypt.dart';
import 'package:client/utils/db.dart';
import 'package:client/chat/conversation.dart';
import 'package:client/chat/message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false; // Variabile di stato per la checkbox
  bool _isObscure = true; // Variabile di stato per la passwordField
  String _errorMessage = ''; // Variabile di stato per il messaggio di errore
  bool _isSnackBarActive = false; // Stato per gestire la visibilità del SnackBar

  Future<bool> _login() async {
    const storage = FlutterSecureStorage();

    List<int> bytes = utf8.encode(_passwordController.text);
    String hash = sha256.convert(bytes).toString();

    bool isValid = (await storage.read(key: 'username') == _usernameController.text) &&
                   (hash == await storage.read(key: 'password'));

    return isValid;
  }

  void _handleLogin() async {
    bool loginSuccess = await _login();
    if(loginSuccess){
      Cryptography.setUpKey(_passwordController.text);
      if(File(await Cryptography.getEncryptedFile()).existsSync()){
        await Cryptography().decryptFile();
      }
      final List<Conversation> conversations = [
    Conversation(
      receiver: 'John Doe',
      lastMessage: 'Hello, how are you?',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100)
    ),
    Conversation(
      receiver: 'Jane Doe',
      lastMessage: 'I am fine, thank you.',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'John Dingo',
      lastMessage: 'What are you doing?',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'Jane Dingo',
      lastMessage: 'I am working on a project.',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'Al Doe',
      lastMessage: 'Can I help you?',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'Moe Rou',
      lastMessage: 'No, thank you.',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100)
    ),
];
  
  conversations.forEach((element) async {
    await insertConversation(element);
  });

  var x = await getConversations();
  x.forEach((element) async {
    await insertMessage(Message(text: '', time: DateTime(2016, 3, 2, 13, 15, 27, 11, 100), type: MessageType.date, sender: '', name: element.receiver));
    await insertMessage(Message(text: 'Hi', time: DateTime(2016, 3, 2, 13, 15, 27, 11, 100), type: MessageType.text, sender: 'not me', name: element.receiver));
  });
    }

    /*
    final List<Conversation> conversations = [
    Conversation(
      receiver: 'John Doe',
      lastMessage: 'Hello, how are you?',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100)
    ),
    Conversation(
      receiver: 'Jane Doe',
      lastMessage: 'I am fine, thank you.',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'John Dingo',
      lastMessage: 'What are you doing?',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'Jane Dingo',
      lastMessage: 'I am working on a project.',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'Al Doe',
      lastMessage: 'Can I help you?',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100),
    ),
    Conversation(
      receiver: 'Moe Rou',
      lastMessage: 'No, thank you.',
      lastMessageTime: DateTime(2016, 3, 2, 13, 15, 27, 11, 100)
    ),
];
  
  conversations.forEach((element) async {
    await insertConversation(element);
  });

  var x = await getConversations();
  x.forEach((element) async {
    await insertMessage(Message(text: '', time: DateTime(2016, 3, 2, 13, 15, 27, 11, 100), type: MessageType.date, sender: '', name: element.receiver));
    await insertMessage(Message(text: 'Hi', time: DateTime(2016, 3, 2, 13, 15, 27, 11, 100), type: MessageType.text, sender: 'not me', name: element.receiver));
  }); */
    setState(() {
      if (loginSuccess) {
        Navigator.pushNamed(context, '/chat');
      } else {
        _errorMessage = AppLocalizations.of(context).loginPageSnackbarError;
        _showSnackBar();
      }
    });
  }

  void _showSnackBar() {
    if (!_isSnackBarActive && _errorMessage.isNotEmpty) {
      _isSnackBarActive = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage),
          duration: const Duration(seconds: 2),
          onVisible: () {
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                _isSnackBarActive = false;
                _errorMessage = ''; // Resetta il messaggio di errore
              });
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).loginPageTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/user.png',
              width: 180, 
              height: 180
              ),
              const SizedBox(height: 30.0),
              Text(
                AppLocalizations.of(context).loginPageDescription,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 70.0),
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: 300.0,
                child: TextField(
                  obscureText: _isObscure,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off
                      ),
                      onPressed: (){
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: 300.0,
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                      },
                    ),
                      Text(AppLocalizations.of(context).loginPageRememberMe),
                    ],
                    ),
                    SizedBox(
                      width: 110.0,
                      height: 45.0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registration');
                        },
                        child: Text(
                          AppLocalizations.of(context).loginPageSignUp,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26.0),
              SizedBox(
                width: 180.0,
                height: 55.0,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  child: Text(
                    AppLocalizations.of(context).loginPageLogin,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
