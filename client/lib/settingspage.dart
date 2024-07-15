import 'package:flutter/material.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        title: Text(AppLocalizations.of(context).settingsPageTitle),
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
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Color.fromARGB(255, 255, 255, 255), width: 0.25),
            bottom: BorderSide(
                color: Color.fromARGB(255, 255, 255, 255), width: 0.25),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                CircleAvatar(
              radius: 40,
              child: ClipOval(
                child: SvgPicture.asset(
                  'images/default_profile.svg',
                  width: 80, 
                  height: 80, 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).settingsPageUsername,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context).settingsPageDescription,
                  style: const TextStyle(fontSize: 18),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset('images/chat_settings.svg'),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context).settingsPageChatSettings,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset('images/language.svg'),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context).settingsPageLanguages,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////credits button///////////////////

  Widget _buildCreditsPage() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/credits');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 23,
              child: ClipOval(
                child: SvgPicture.asset(
                  'images/info.svg',
                  width: 80, 
                  height: 80, 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context).settingsPageCredits,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
