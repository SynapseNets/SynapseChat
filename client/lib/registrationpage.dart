import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Registrationpage extends StatefulWidget {
  const Registrationpage({super.key});

  @override
  State<Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  bool _isObscure = true;

  Future<bool> _register() async {
    if(_password1.text != _password2.text){
      return false;
    }

    List<int> bytes = utf8.encode(_password1.text);
    String hash = sha256.convert(bytes).toString();

    const storage = FlutterSecureStorage();
    await storage.write(key: 'username', value: _username.text);
    await storage.write(key: 'password', value: hash);

    return true;
    //registration logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).registrationPageTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Image.asset(
              'images/user.png',
              width: 140,
              height: 140,
            ),
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context).registrationPageDescription,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: _username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: _isObscure,
                controller: _password1,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300.0,
              child: TextField(
                obscureText: _isObscure,
                controller: _password2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).registrationPageRepeatPw,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 180.0,
              height: 55.0,
              child: ElevatedButton(
                onPressed: () async {
                    await _register() ?  Navigator.pushNamed(context, '/login') : print("registration denied"); //TODO: add popup for failed signup
                  },
                child: Text(
                  AppLocalizations.of(context).registrationPageRegistration,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
