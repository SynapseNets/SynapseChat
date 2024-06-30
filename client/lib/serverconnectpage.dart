import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';

class Serverconnectpage extends StatefulWidget {
  const Serverconnectpage({super.key});

  @override
  State<Serverconnectpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Serverconnectpage> {
  final TextEditingController _serverIP = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool connectToServer() {
    String serverIP = _serverIP.text;
    String password = _password.text;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).serverConnectPageTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Image.asset(
              'images/logo.png', //change
              width: 140,
              height: 140,
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).serverConnectPageDescription,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: _serverIP,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).serverConnectPageIp,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 180.0,
              height: 55.0,
              child: ElevatedButton(
                onPressed: () {
                  connectToServer()
                      ? Navigator.pushNamed(context, '/chat')
                      : print("connection to server denied");
                },
                child: Text(
                   AppLocalizations.of(context).serverConnectPageConnect,
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
