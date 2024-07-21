import 'package:flutter/material.dart';
import 'package:client/main.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:client/utils/settings_preferences.dart';

class RoundCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const RoundCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged!(!value);
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: value
            ? const Icon(
                Icons.radio_button_on,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class ChatLanguagesPage extends StatefulWidget {
  const ChatLanguagesPage({super.key});

  @override
  State<ChatLanguagesPage> createState() => _ChatLanguagesPageState();
}

class _ChatLanguagesPageState extends State<ChatLanguagesPage> {
  double sizeChar = 15;
  int _selectedCheckboxIndex = -1; // -1 means no checkbox is selected

  // Function to create a row with checkbox, texts, and extra text
  Widget _buildCheckboxRow(
      int index, String primaryText, String secondaryText, String extraText) {
    return Row(
      children: [
        RoundCheckbox(
          value: _selectedCheckboxIndex == index,
          onChanged: (bool? value) async {
            SettingsPreferences.setLanguage(
                primaryText.substring(0, 2).toLowerCase());
            setState(() {
              SynapseNetsApp.setLocale(
                  context,
                  Locale.fromSubtags(
                      languageCode: primaryText.substring(0, 2).toLowerCase()));
              _selectedCheckboxIndex = value! ? index : -1;
            });
          },
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                primaryText,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                secondaryText,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                extraText,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).languagesPageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCheckboxRow(
                0, 'Italiano', 'Italian', 'Il sole splende alto nel cielo'),
            const SizedBox(height: 25),
            _buildCheckboxRow(
                1, 'English', 'English', 'The sun shines high in the sky'),
            const SizedBox(height: 25),
            _buildCheckboxRow(
                2, 'Español', 'Spanish', 'El sol brilla alto en el cielo'),
          ],
        ),
      ),
    );
  }
}
