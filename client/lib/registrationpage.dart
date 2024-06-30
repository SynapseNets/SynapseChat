import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';

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

  bool _register() {
    String username = _username.text;
    String first_password = _password1.text;
    String second_password = _password2.text;

    return true;
    //logica per la registrazione
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).registrationPage_title),
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
              AppLocalizations.of(context).registrationPage_description,
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
                  labelText: AppLocalizations.of(context).registrationPage_repeatPw,
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
                onPressed: (){
                   _register() ?  Navigator.pushNamed(context, '/login') : print("registration denied");
                  },
                child: Text(
                  AppLocalizations.of(context).registrationPage_registration,
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
