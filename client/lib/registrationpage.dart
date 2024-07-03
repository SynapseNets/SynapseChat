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
  bool _isPasswordValid = false;
  bool _isUsernameValid = false;
  String _passwordError = '';
  String _usernameError = '';
  String _password2Error = '';
  String _registrationStatus = '';

  @override
  void initState() {
    super.initState();
    _password2.addListener(_validatePassword2);
  }

  @override
  void dispose() {
    _password2.removeListener(_validatePassword2);
    super.dispose();
  }

  Future<void> _register() async {
    bool isValid = _validateInputs();

    if (!isValid) {
      setState(() {
        _registrationStatus = 'Accesso negato: Correggere gli errori nei campi sopra.';
      });
      return;
    }

    List<int> bytes = utf8.encode(_password1.text);
    String hash = sha256.convert(bytes).toString();

    const storage = FlutterSecureStorage();
    await storage.write(key: 'username', value: _username.text);
    await storage.write(key: 'password', value: hash);

    setState(() {
      _registrationStatus = 'Registrazione completata!';
    });

    Navigator.pushNamed(context, '/login');
  }

  bool _validateInputs() {
    bool isUsernameValid = _validateUsername(_username.text);
    bool isPasswordValid = _validatePassword(_password1.text);
    bool isPassword2Valid = _validatePassword2();

    return isUsernameValid && isPasswordValid && isPassword2Valid;
  }

  bool _validateUsername(String username) {
    setState(() {
      if (username.isEmpty) {
        _usernameError = 'Lo username non deve essere vuoto';
        _isUsernameValid = false;
      } else {
        _usernameError = '';
        _isUsernameValid = true;
      }
    });
    return _isUsernameValid;
  }

  bool _validatePassword(String password) {
    setState(() {
      final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
      if (!regex.hasMatch(password)) {
        _passwordError = 'La password deve essere lunga almeno 8 caratteri e\nincludere un numero e un carattere speciale.';
        _isPasswordValid = false;
      } else {
        _passwordError = '';
        _isPasswordValid = true;
      }
    });
    return _isPasswordValid;
  }

  bool _validatePassword2() {
  bool isValid = true;

  setState(() {
    if (_password1.text != _password2.text) {
      _password2Error = 'Le password non coincidono';
      isValid = false;
    } else {
      _password2Error = '';
      isValid = true;
    }
  });

  return isValid;
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
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _username,
                    onChanged: _validateUsername,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: const OutlineInputBorder(),
                      errorText: _usernameError.isEmpty ? null : _usernameError,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    obscureText: _isObscure,
                    controller: _password1,
                    onChanged: _validatePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      errorText: _passwordError.isEmpty ? null : _passwordError,
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
                    onChanged: (_) {
                      _validatePassword2();
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).registrationPageRepeatPw,
                      border: const OutlineInputBorder(),
                      errorText: _password2Error.isEmpty ? null : _password2Error,
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
                      await _register();
                      if (_registrationStatus.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_registrationStatus),
                          ),
                        );
                      }
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
