import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

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
            _buildCustomizationButton(),
            _buildCustomizationLanguages(),
            _buildCreditsPage()
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
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/default_profile.png')
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nome Utente',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Descrizione Utente',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////customization chat button///////////////////

  Widget _buildCustomizationButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/chatsettings');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('images/chat_settings.png')
            ),
            SizedBox(width: 12),
            Text(
              'Chat settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////change languages button///////////////////

  Widget _buildCustomizationLanguages() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/languagesettings');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('images/language.png')
            ),
            SizedBox(width: 12),
            Text(
              'Languages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////change languages button///////////////////

  Widget _buildCreditsPage() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/languagesettings');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('images/language.png')
            ),
            SizedBox(width: 12),
            Text(
              'Credits',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
