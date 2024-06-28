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
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Icons credits',
          style: TextStyle(
            color: Color(0xff3b28cc),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          children: [
            //////////////////////////////INFO////////////////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/info.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          LaunchUrl('https://www.flaticon.com/free-icons/info'),
                      child: const Text(
                        '   Info icons created by Anggara - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////CHAT SETTINGS///////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/chat_settings.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () => LaunchUrl(
                          'https://www.flaticon.com/free-icons/message'),
                      child: const Text(
                        '   Message icons created by Fathema Khanom - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////BACKGROUND///////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/background.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () => LaunchUrl(
                          'https://www.flaticon.com/free-icons/gallery'),
                      child: const Text(
                        '   Gallery icons created by adrianadam - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////ADD_SERVER///////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/add_server.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () => LaunchUrl(
                          'https://www.flaticon.com/free-icons/add-database'),
                      child: const Text(
                        '   Add database icons created by Arafat Uddin - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////DEFAULT_PROFILE///////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/default_profile.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          LaunchUrl('https://www.flaticon.com/free-icons/user'),
                      child: const Text(
                        '   User icons created by Freepik - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////USER///////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/user.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () => LaunchUrl(
                          'https://www.flaticon.com/free-icons/profile-image'),
                      child: const Text(
                        '   Profile image icons created by Md Tanvirul Haque - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////LANGUAGE///////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/language.png'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () => LaunchUrl(
                          'https://www.flaticon.com/free-icons/earth-globe'),
                      child: const Text(
                        '   Earth globe icons created by Freepik - Flaticon',
                        style: TextStyle(
                          color: Color(0xff3b28cc),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
