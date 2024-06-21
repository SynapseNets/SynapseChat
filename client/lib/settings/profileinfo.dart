import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profileinfo extends StatefulWidget {
  const Profileinfo({super.key});

  @override
  State<Profileinfo> createState() => _ProfileinfoState();
}

class _ProfileinfoState extends State<Profileinfo> {
  File?_image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null){setState(() {
      _image = File(image.path);
    });}
  }
   @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Profile'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20), // Add some space from the top AppBar
          CircleAvatar(
            radius: 80,
            backgroundImage: _image == null
                ? const AssetImage('images/default_profile.png')
                : FileImage(_image!) as ImageProvider,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Change Profile Picture'),
          ),
          const SizedBox(height: 70),
          const SizedBox(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: 250.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'This is the name your contacts will see \nIs not related to your login username',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const SizedBox(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Info',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: 250.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Describe yourself briefly',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}