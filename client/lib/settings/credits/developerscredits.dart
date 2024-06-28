import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developerscredits extends StatefulWidget {
  const Developerscredits({Key? key}) : super(key: key);

  @override
  State<Developerscredits> createState() => _DeveloperscreditsState();
}

class _DeveloperscreditsState extends State<Developerscredits> {
  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildGitHubProfile(String url, String imageUrl, String githubName, String name, String additionalText) {
    return InkWell(
      onTap: () {
        _launchURL(url);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      githubName,
                      style: const TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      additionalText,
                      style: const TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Developers Credits',
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
            buildGitHubProfile(
              'https://github.com/AlBovo/AlBovo',
              'https://avatars.githubusercontent.com/u/88632271?v=4',
              'AlBovo',
              'Alan Davide Bovo',
              'Server Developer'
            ),
            const Divider(color: Color(0xff1b2a41), thickness: 2),
            buildGitHubProfile(
              'https://github.com/Mark-74',
              'https://avatars.githubusercontent.com/u/110310114?v=4',
              'Mark-74',
              'Marco Balducci',
              'Frontend and Backend Developer for Client'
            ),
            const Divider(color: Color(0xff1b2a41), thickness: 2),
            buildGitHubProfile(
              'https://github.com/MattiaCincotta',
              'https://avatars.githubusercontent.com/u/146827826?s=400&u=9407e6239be9581eefe639ae41138c053fc4d11c&v=4',
              'MattiaCincotta',
              'Mattia Cincotta',
              'Frontend Developer for Client'
            ),
            const Divider(color: Color(0xff1b2a41), thickness: 2),
            buildGitHubProfile(
              'https://github.com/Lorii0',
              'https://avatars.githubusercontent.com/u/146861747?v=4',
              'Lorii0',
              'Lorenzo Shani',
              'Frontend Developer for Client'
            ),
            const Divider(color: Color(0xff1b2a41), thickness: 2),
            buildGitHubProfile(
              'https://github.com/Antostarwars/Antostarwars',
              'https://avatars.githubusercontent.com/u/67382924?v=4',
              'Antostarwars',
              'Antonio De Rosa',
              'Additional text for Antonio De Rosa'
            ),
            const Divider(color: Color(0xff1b2a41), thickness: 2),
          ],
        ),
      ),
    );
  }
}
