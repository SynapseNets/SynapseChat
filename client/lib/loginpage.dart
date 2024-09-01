import 'dart:io';
import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:client/utils/encrypt.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;
  bool _isObscure = true;
  String _errorMessage = '';
  bool _isSnackBarActive = false;

  Future<bool> _login() async {

    const storage = FlutterSecureStorage();
    if(await storage.read(key: 'remember') == 'true') {
      return true;
    }

    List<int> bytes = utf8.encode(_passwordController.text);
    String hash = sha256.convert(bytes).toString();

    bool isValid = (await storage.read(key: 'username') == _usernameController.text) &&
                   (hash == await storage.read(key: 'password'));

    return isValid;
  }

  void _handleLogin() async {
    const storage = FlutterSecureStorage();

    bool loginSuccess = await _login();
    if (loginSuccess) {

      await storage.read(key: 'remember') == 'true' ? 
      Cryptography.setUpKeyFromHash((await storage.read(key: 'key'))!) : 
      Cryptography.setUpKey(_passwordController.text);

      if (File(await Cryptography.getEncryptedFile()).existsSync()) {
        await Cryptography().decryptFile();
      }

      if(_isChecked){
        await storage.write(key: 'remember', value: 'true');
        await storage.write(key: 'key', value: md5.convert(utf8.encode(_passwordController.text)).toString());
      } else {
        await storage.write(key: 'remember', value: 'false');
        await storage.write(key: 'key', value: null);
      }

      //WebSocket
      /*
      final webSocketProvider = Provider.of<WebSocketProvider>(context, listen: false);
      webSocketProvider.connect('ws://localhost:8765'); 
      webSocketProvider.sendMessage('test message');
      */
      storage.write(key: 'logged', value: 'true');
      Navigator.pushNamed(context, '/chat');
    } else {
      setState(() {
        _errorMessage = AppLocalizations.of(context).loginPageSnackbarError;
        _showSnackBar();
      });
    }
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
                _errorMessage = '';
              });
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    const storage = FlutterSecureStorage();
    storage.read(key: 'remember').then((value) => {
      if(value == 'true'){
        _handleLogin()
      }
    });
    super.initState();
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
              SvgPicture.asset(
                'images/user.svg',
                width: 180,
                height: 180,
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
              const SizedBox(height: 5.0),
              SizedBox(
                width: 300.0,
                child: Row(
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
