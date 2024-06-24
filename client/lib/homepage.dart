import 'package:flutter/material.dart';

const List<String> languages = <String>['English', 'Italiano', 'Español'];

class SynapseNetsAppHomepage extends StatefulWidget {
  const SynapseNetsAppHomepage({super.key});

  @override
  State<SynapseNetsAppHomepage> createState() => _SynapseNetsAppHomepageState();
}

class _SynapseNetsAppHomepageState extends State<SynapseNetsAppHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 256,
              height: 256,
            ),
            const Text(
              'Welcome to SynapseChat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('The most secure messaging service available.'),
            const SizedBox(height: 50),
            const Text(
              'Select your language',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const LanguageDropDown(),
            const SizedBox(height: 100),
            SizedBox(
              height: 75,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Continue', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  String? dropDownValue;
  final List<String> _options = ['English', 'Italiano', 'Español'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: DropdownButtonFormField<String>(
          value: dropDownValue,
          hint: const Text('English'),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          decoration: InputDecoration(
            labelText: 'Options',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue;
            });
          },
          items: _options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
