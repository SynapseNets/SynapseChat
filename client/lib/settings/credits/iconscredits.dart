import 'package:flutter/material.dart';

class Iconscredits extends StatefulWidget {
  const Iconscredits({super.key});

  @override
  State<Iconscredits> createState() => _IconscreditsState();
}

class _IconscreditsState extends State<Iconscredits> {
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          children: [
            //////////////////////////////INFO////////////////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/info.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/info'
                      '   Info icons created by Anggara - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////CHAT SETTINGS///////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/chat_settings.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/message'
                      '   Message icons created by Fathema Khanom - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////BACKGROUND///////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/background.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/gallery'
                      '   Gallery icons created by adrianadam - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////ADD_SERVER///////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/add_server.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/add-database'
                      '   Add database icons created by Arafat Uddin - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////DEFAULT_PROFILE///////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/default_profile.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/user'
                      '   User icons created by Freepik - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////USER///////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/user.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/profile-image'
                      '   Profile image icons created by Md Tanvirul Haque - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xff1b2a41),
              thickness: 2,
            ),
            /////////////////////////////LANGUAGE///////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/language.png'),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      'https://www.flaticon.com/free-icons/earth-globe'
                      '   Earth globe icons created by Freepik - Flaticon',
                      style: TextStyle(
                        color: Color(0xff3b28cc),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
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
