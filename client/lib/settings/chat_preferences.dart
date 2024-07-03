import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:client/l10n/app_localizations.dart';

class ChatPreferencesPage extends StatefulWidget {
  const ChatPreferencesPage({super.key});

  @override
  State<ChatPreferencesPage> createState() => _ChatPreferencesPageState();
}

class _ChatPreferencesPageState extends State<ChatPreferencesPage> {
  double sizeChar = 15;
  Color backgroundColor = const Color.fromARGB(255, 134, 120, 235);
  Color textColor = Colors.white;
  bool isDarkTheme = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
      if (isDarkTheme) {
        lightThemeSelected = false;
        darkThemeSelected = true;
      } else {
        lightThemeSelected = true;
        darkThemeSelected = false;
      }
    });
  }

  bool lightThemeSelected = true;
  bool darkThemeSelected = false;

  @override
  void initState() {
    super.initState();
    // Initialize theme based on system theme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var brightness = MediaQuery.of(context).platformBrightness;
      setState(() {
        isDarkTheme = brightness == Brightness.dark;
        if (isDarkTheme) {
          lightThemeSelected = false;
          darkThemeSelected = true;
        } else {
          lightThemeSelected = true;
          darkThemeSelected = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).chatPreferencesTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).chatPreferencesFontSize,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      sizeChar.toInt().toString(),
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Slider(
                  value: sizeChar,
                  min: 15,
                  max: 30,
                  divisions: 15,
                  label: sizeChar.toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      sizeChar = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff1b2a41),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                           AppLocalizations.of(context).chatPreferencesFirstText,
                            style: TextStyle(fontSize: sizeChar, color: textColor),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff3b28cc),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            AppLocalizations.of(context).chatPreferencesSecondText,
                            style: TextStyle(fontSize: sizeChar, color: textColor),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xff1b2a41),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            AppLocalizations.of(context).chatPreferencesThirdText,
                            style: TextStyle(fontSize: sizeChar, color: textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    // Open a dialog to change the background color
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context).chatPreferencesTextDialogBackground),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: backgroundColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  backgroundColor = color;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'images/background.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context).chatPreferencesBackground,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // Open a dialog to change the text color
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context).chatPreferencesTextDialogColor),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: textColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  textColor = color;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.text_fields,
                        size: 40,
                        color: textColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context).chatPreferencesTextColor,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context).chatPreferencesLightTheme),
                  value: lightThemeSelected,
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      toggleTheme(false);
                    }
                  },
                ),
                CheckboxListTile(
                  title: Text(AppLocalizations.of(context).chatPreferencesDarkTheme),
                  value: darkThemeSelected,
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      toggleTheme(true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
