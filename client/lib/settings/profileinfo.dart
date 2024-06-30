import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:client/l10n/app_localizations.dart';

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
      title: Text(AppLocalizations.of(context).profilePageTitle),
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
            child: Text(AppLocalizations.of(context).profilePageChangePicture),
          ),
          const SizedBox(height: 70),
          SizedBox(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).profilePageName,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 250.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).profilePageDescriptionName,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).profilePageBiography,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 250.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).profilePageDescriptionBiography,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}