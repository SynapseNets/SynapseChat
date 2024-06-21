import 'package:flutter/material.dart';
import 'dart:io';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File?_image;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileInfoButton(),
            _buildcustomizationButton(),
          ],
        ),
      ),
    );
  }


  ///////////////////edit profile button///////////////////

  Widget _buildProfileInfoButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/profileinfo');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)!, width: 0.25),
            bottom: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)!, width: 0.25),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundImage: _image == null
                  ? const AssetImage('images/default_profile.png')
                  : FileImage(_image!) as ImageProvider,
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nome Utente',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Descrizione Utente',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////customization chat button///////////////////

  Widget _buildcustomizationButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/chatsettings');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.messenger_outlined), // Esempio di icona
            SizedBox(width: 12),
            Text(
              'Chat settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
