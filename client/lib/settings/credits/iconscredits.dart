import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Iconscredits extends StatefulWidget {
  const Iconscredits({super.key});

  @override
  State<Iconscredits> createState() => _IconscreditsState();
}

class _IconscreditsState extends State<Iconscredits> {
  void LaunchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildIconCredit(String imageUrl, String description, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => LaunchUrl(url),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white, // Background color for transparent images
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      imageUrl,
                      width: 80, // Adjust the width and height as needed
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Color(0xff1b2a41),
          thickness: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Icons credits',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: [
            buildIconCredit('images/info.png', 'Info icons created by Anggara - Flaticon', 'https://www.flaticon.com/authors/anggara'),
            buildIconCredit('images/chat_settings.png', '   Message icons created by Fathema Khanom - Flaticon', 'https://www.flaticon.com/authors/fathema-khanom'),
            buildIconCredit('images/background.png', '   Gallery icons created by adrianadam - Flaticon', 'https://www.flaticon.com/authors/adrianadam'),
            buildIconCredit('images/add_server.png', '   Add database icons created by Arafat Uddin - Flaticon', 'https://www.flaticon.com/authors/arafat-uddin'),
            buildIconCredit('images/default_profile.png', '   User icons created by Freepik - Flaticon', 'https://www.flaticon.com/authors/freepik'),
            buildIconCredit('images/user.png', '   Profile image icons created by Md Tanvirul Haque - Flaticon', 'https://www.flaticon.com/authors/md-tanvirul-haque'),
            buildIconCredit('images/language.png', '   Earth globe icons created by Freepik - Flaticon', 'https://www.flaticon.com/authors/freepik'),
          ],
        ),
      ),
    );
  }
}
