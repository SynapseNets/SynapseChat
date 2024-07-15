import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Aggiunto per usare TextInputFormatter
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:client/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Registrationpage extends StatefulWidget {
  const Registrationpage({Key? key}) : super(key: key);

  @override
  State<Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  bool _isObscure = true;
  bool _isUsernameNotEmpty = false;
  bool _isUsernameInteracted = false; // Stato per verificare se l'utente ha interagito con lo username
  bool _isPassword1Valid = false; // Stato per verificare se la password1 è valida
  bool _isPassword1Interacted = false; // Stato per verificare se l'utente ha interagito con la password1
  bool _isPassword2Interacted = false; // Stato per verificare se l'utente ha interagito con la password2

  @override
  void initState() {
    super.initState();
    _isUsernameNotEmpty = _username.text.isNotEmpty;
    _isPassword1Valid = _validatePassword1(_password1.text);
    _username.addListener(_onUsernameChange);
    _password1.addListener(_onPassword1Change);
    _password2.addListener(_onPassword2Change);
  }

  @override
  void dispose() {
    _username.removeListener(_onUsernameChange);
    _password1.removeListener(_onPassword1Change);
    _password2.removeListener(_onPassword2Change);
    super.dispose();
  }

  void _onUsernameChange() {
    setState(() {
      _isUsernameInteracted = true;
      _isUsernameNotEmpty = _username.text.isNotEmpty;
    });
  }

  void _onPassword1Change() {
    setState(() {
      _isPassword1Interacted = true;
      _isPassword1Valid = _validatePassword1(_password1.text);
    });
  }

  void _onPassword2Change() {
    setState(() {
      _isPassword2Interacted = true;
    });
  }

  Future<void> _register() async {
    bool isValid = _validateInputs();

    if (!isValid) {
      _showSnackBar(AppLocalizations.of(context).registrationPageSnackbarError);
      return;
    }

    List<int> bytes = utf8.encode(_password1.text);
    String hash = sha256.convert(bytes).toString();

    const storage = FlutterSecureStorage();
    await storage.write(key: 'username', value: _username.text);
    await storage.write(key: 'password', value: hash);

    Navigator.pushNamed(context, '/login');
  }

  bool _validateInputs() {
    bool isUsernameValid = _validateUsername(_username.text);
    bool isPassword1Valid = _validatePassword1(_password1.text);
    bool isPassword2Valid = _validatePassword2();

    return isUsernameValid && isPassword1Valid && isPassword2Valid;
  }

  bool _validateUsername(String username) {
    return username.isNotEmpty;
  }

  bool _validatePassword1(String password) {
    final regex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    bool isValid = regex.hasMatch(password);
    return isValid;
  }

  bool _validatePassword2() {
    return _password1.text == _password2.text;
  }


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).registrationPageTitle),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                SvgPicture.asset(
                  'images/user.svg',
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
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _username,
                    onChanged: (value) {
                      _validateUsername(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _isUsernameInteracted && !_isUsernameNotEmpty,
                  child: Text(
                    AppLocalizations.of(context).registrationPageUsernameError,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    obscureText: _isObscure,
                    controller: _password1,
                    onChanged: (_) {
                      setState(() {
                        _isPassword1Interacted = true;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                const SizedBox(height: 10),
                Visibility(
                  visible: _isPassword1Interacted && (!_isPassword1Valid || !_isObscure),
                  child: Text(
                    AppLocalizations.of(context).registrationPageFirstPasswordError,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    obscureText: _isObscure,
                    controller: _password2,
                    onChanged: (_) {
                      setState(() {
                        _isPassword2Interacted = true;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).registrationPageRepeatPw,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                const SizedBox(height: 10),
                Visibility(
                  visible: _isPassword2Interacted && _password1.text != _password2.text,
                  child: Text(
                    AppLocalizations.of(context).registrationPageSecondPasswordError,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 180.0,
                  height: 55.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _register();
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
        ),
      ),
    );
  }
}
