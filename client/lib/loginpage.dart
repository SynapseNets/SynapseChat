import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:client/utils/encrypt.dart';

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
    if (loginSuccess) {
      Cryptography _crypt = Cryptography(_passwordController.text);
      //await _crypt.encryptFile();

      Navigator.pushNamed(context, '/chat');
    } else {
      _errorMessage = 'Nome utente o password sbagliati';
      _showSnackBar();
    }
    setState(() {});
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
