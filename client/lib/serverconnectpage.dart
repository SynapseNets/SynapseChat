import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:client/utils/db.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class Serverconnectpage extends StatefulWidget {
  const Serverconnectpage({super.key});

  @override
  State<Serverconnectpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Serverconnectpage> {
  final TextEditingController _serverIP = TextEditingController();
  final TextEditingController _port = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<bool> connectToServer() async {
    String serverIP = _serverIP.text;
    int port;
    //String password = _password.text; TODO
    try {
      port = int.parse(_port.text);
    } catch (e) {
      return false;
    }

    if (serverIP.isEmpty) {
      return false;
    }

    const storage = FlutterSecureStorage();
    final client = http.Client();

    String? _username = await storage.read(key: 'username');
    var response;

    try {
      response = await client.post(
          Uri.parse('https://$serverIP:$port/api/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'username': _username!}));
    } catch (e) {
      return false;
    }

    if (response.statusCode != 201) {
      return false;
    }

    var body = json.decode(response.body);
    String totpUri = body['auth'];

    await addServer(serverIP, port, _username!, totpUri);

    showDialog(
        context: context,
        builder: (context) => Dialog(
                child: SizedBox(
              height: Platform.isAndroid || Platform.isIOS ? 475 : 350,
              child: Column(children: [
                const SizedBox(height: 20),
                const Text('Add TOTP to your Authenticator'),
                const SizedBox(height: 20),
                QrImageView(
                  data: totpUri,
                  size: 256,
                  backgroundColor: Colors.white,
                ),
                Builder(builder: (context) {
                  if (Platform.isAndroid || Platform.isIOS) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text('Scan the QR code with your Authenticator'),
                        const SizedBox(height: 20),
                        const Text('or'),
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () async {
                              Uri url = Uri.parse(totpUri);
                              await launchUrl(url, mode: LaunchMode.externalApplication); //TODO: add popup if not successfull            
                            },
                            child: const Text('Add to Google Authenticator'))
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ]),
            )));

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
            const SizedBox(height: 20),
            SizedBox(
              width: 300.0,
              child: TextField(
                controller: _port,
                decoration: const InputDecoration(
                  labelText: 'port',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 180.0,
              height: 55.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (!(await connectToServer())) {
                    //TODO: show error message
                    print('error');
                  }
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
