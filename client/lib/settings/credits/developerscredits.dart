import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client/l10n/app_localizations.dart';

class Developerscredits extends StatefulWidget {
  const Developerscredits({super.key});

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

  Widget buildGitHubProfile(String url, String imageUrl, String githubName, String name, String role) {
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      role,
                      style: const TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xff1b2a41), thickness: 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).developerscreditsPageTitle,
          style: const TextStyle(
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
              AppLocalizations.of(context).developerscreditsPageDescriptionAlBovo
            ),
            buildGitHubProfile(
              'https://github.com/Mark-74',
              'https://avatars.githubusercontent.com/u/110310114?v=4',
              'Mark-74',
              'Marco Balducci',
              AppLocalizations.of(context).developerscreditsPageDescriptionMark74
            ),
            buildGitHubProfile(
              'https://github.com/MattiaCincotta',
              'https://avatars.githubusercontent.com/u/146827826?s=400&u=9407e6239be9581eefe639ae41138c053fc4d11c&v=4',
              'MattiaCincotta',
              'Mattia Cincotta',
              AppLocalizations.of(context).developerscreditsPageDescriptionMattiaCincotta
            ),
            buildGitHubProfile(
              'https://github.com/Lorii0',
              'https://avatars.githubusercontent.com/u/146861747?v=4',
              'Lorii0',
              'Lorenzo Shani',
              AppLocalizations.of(context).developerscreditsPageDescriptionLorii0
            ),
            buildGitHubProfile(
              'https://github.com/Antostarwars/Antostarwars',
              'https://avatars.githubusercontent.com/u/67382924?v=4',
              'Antostarwars',
              'Antonio De Rosa',
              AppLocalizations.of(context).developerscreditsPageDescriptionAntostarwars
            ),
          ],
        ),
      ),
    );
  }
}
