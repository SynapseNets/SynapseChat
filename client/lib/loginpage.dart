import 'dart:ffi';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false; // Variabile di stato per la checkbox

  void _login() {
    // Logica di autenticazione va qui
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool rememberMe = _isChecked;
    // Stampa a console (solo per debug)
    print('Username: $username');
    print('Password: $password');
    print('Remember Me: $rememberMe');

    // Puoi aggiungere qui la logica di autenticazione con il backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              const Text(
                'Login to SynapseChat',
                style: TextStyle(
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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: 300.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Text('Remember Me'),
                    const SizedBox(width: 80,),
                    SizedBox(
                      width: 90.0,
                      height: 30.0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registration');
                        },
                        child: const Text(
                          'sign up',
                          style: TextStyle(fontSize: 16.0),
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
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(
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
