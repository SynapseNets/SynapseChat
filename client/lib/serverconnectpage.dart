import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:client/utils/db.dart';
import 'package:otp_util/otp_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


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

    String? username = await storage.read(key: 'username');
    http.Response response;

    try {
      response = await client.post(
          Uri.parse('https://$serverIP:$port/api/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'username': username!}));
    } catch (e) {
      return false;
    }

    if (response.statusCode != 201) {
      return false;
    }

    var body = json.decode(response.body);
    String totpUri = body['auth'];

    if (!totpUri.startsWith('otpauth://totp/')) {
      return false;
    }

    await addServer(serverIP, port, username, totpUri);

    //login
    TOTP totp = TOTP(secret: totpUri.split('secret=')[1].split('&')[0]);
    var totpResponse = await client.post(Uri.parse('https://$serverIP:$port/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'otp': totp.now(),
          }));
    
    if (totpResponse.statusCode != 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min, 
              children: <Widget>[
                Image.asset('images/error.svg'), 
                const SizedBox(height: 16.0), 
                const Text('Server did not provide an acceptable response'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }

    //saving session-token
    await storage.write(key: 'serverIP', value: json.decode(totpResponse.body)['auth']);

    IO.Socket socket = IO.io("https://$serverIP:$port", <String, dynamic>{
      'transports': ['websocket'],
    });

    socket = socket.connect();
    socket.onConnect((_) {
      print('connection established');
      socket.emit('connect', {});
    });
    socket.onError((err)=>print(err));
    socket.onConnectError((err)=>print(err));
    socket.onDisconnect((_)=>print("connection Disconnection"));

    bool connected = false;
    Timer(const Duration(seconds: 5), () => (){if(!connected) {socket.disconnect(); return false;}});

    socket.on('connected', (data) {
      print('connected received');
      if(data['status'] == 'ok') {
        //connected = true;
        switchServer(serverIP);
        Navigator.pushNamed(context, '/chat');
      }
    });

    //if everything works, the socket is closed
    socket.close();

    showDialog(
        context: context,
        builder: (context) => Dialog(
                child: SizedBox(
              height: Platform.isAndroid || Platform.isIOS ? 475 : 350,
              child: Column(children: [
                const SizedBox(height: 20),
                Text(AppLocalizations.of(context)
                    .serverConnectPageFirstStringAuthenticatorPopUp),
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
                        Text(AppLocalizations.of(context)
                            .serverConnectPageSecondStringAuthenticatorPopUp),
                        const SizedBox(height: 20),
                        Text(AppLocalizations.of(context)
                            .serverConnectPageThirdStringAuthenticatorPopUp),
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () async {
                              Uri url = Uri.parse(totpUri);

                              try {
                                await launchUrl(url,
                                    mode: LaunchMode
                                        .externalApplication); 
                              } catch (e) {
                                print('Caught an exception: $e');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            SvgPicture.asset(
                                              'images/error.svg',
                                              height: 65,
                                              width: 65,
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Error',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors
                                                      .red), // Stile personalizzato per il titolo
                                            ),
                                          ],
                                        ),
                                        content: const Text(   //TODO: add link to install google authenticator
                                          '"Error with Google Authenticator"',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Text(AppLocalizations.of(context)
                                .serverConnectPageFourthStringAuthenticatorPopUp))
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                })
              ]),
            )
          )
        );

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
            SvgPicture.asset(
              'images/logo.svg', //change
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                SvgPicture.asset(
                                  'images/error.svg',
                                  height: 65,
                                  width: 65,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  AppLocalizations.of(context)
                                      .serverConnectPageTitleErrorConnectionPopUp,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .red), // Stile personalizzato per il titolo
                                ),
                              ],
                            ),
                            content: Text(
                              AppLocalizations.of(context)
                                  .serverConnectPageContentErrorConnectionPopUp,
                              style: const TextStyle(fontSize: 20),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .serverConnectPageButtonErrorConnectionPopUp,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
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
