import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client/l10n/app_localizations.dart';
import 'package:client/utils/settings_preferences.dart';

class ChatPreferencesPage extends StatefulWidget {
  const ChatPreferencesPage({Key? key}) : super(key: key);

  @override
  _ChatPreferencesPageState createState() => _ChatPreferencesPageState();
}

class _ChatPreferencesPageState extends State<ChatPreferencesPage> {
  double sizeChar = 15.0;
  Color backgroundColor = const Color.fromARGB(255, 134, 120, 235);
  Color textColor = Colors.white;
  bool isDarkTheme = true;
  Widget? backgroundImage;

  void loadPreferences() {
    Future.wait([
      SettingsPreferences.getFontSize(),
      SettingsPreferences.getBackgroundColor(),
      SettingsPreferences.getTextColor(),
      SettingsPreferences.getDarkMode(),
    ]).then((values) {
      setState(() {
        sizeChar = values[0] as double;
        backgroundColor = Color(values[1] as int);
        textColor = Color(values[2] as int);
        isDarkTheme = values[3] as bool;
        setBackgroundImage();
      });
    }).catchError((error) {
      print('Error loading preferences: $error');
    });
  }

  void setBackgroundImage() {
    setState(() {
      try {
        backgroundImage = SvgPicture.asset(
          'images/background_chat.svg',
          colorFilter: ColorFilter.mode(backgroundColor, BlendMode.color),
          fit: BoxFit.cover, // Assicura che l'immagine si adatti senza distorsione
        );
      } catch (e) {
        print('Error loading background image: $e');
        // Gestisci l'eccezione in base alla tua logica (es. visualizzare un'immagine alternativa o un messaggio di errore)
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
    // Inizializza il tema in base al tema di sistema
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var brightness = MediaQuery.of(context).platformBrightness;
      setState(() {
        isDarkTheme = brightness == Brightness.dark;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chatPreferencesTitle),
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
                    AppLocalizations.of(context)!.chatPreferencesFontSize,
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
                onChanged: (double value) async {
                  await SettingsPreferences.setFontSize(value);
                  setState(() {
                    sizeChar = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.5, // Altezza massima dello schermo
                width: MediaQuery.of(context).size.width, // Larghezza massima dello schermo
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    if (backgroundImage != null) backgroundImage!, // Utilizzo dell'immagine di sfondo se non è nulla
                    ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xff1b2a41).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .chatPreferencesFirstText,
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
                              color: const Color(0xff3b28cc).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .chatPreferencesSecondText,
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
                              color: const Color(0xff1b2a41).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .chatPreferencesThirdText,
                              style: TextStyle(fontSize: sizeChar, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  // Apri un dialog per cambiare il colore dello sfondo
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context)!
                            .chatPreferencesTextDialogBackground),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: backgroundColor,
                            onColorChanged: (Color color) async {
                              await SettingsPreferences.setBackgroundColor(
                                  color.value);
                              setState(() {
                                backgroundColor = color;
                                setBackgroundImage();
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
                    SvgPicture.asset(
                      'images/background_color.svg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.chatPreferencesBackground,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  // Apri un dialog per cambiare il colore del testo
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context)!
                            .chatPreferencesTextDialogColor),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: textColor,
                            onColorChanged: (Color color) async {
                              await SettingsPreferences.setTextColor(
                                  color.value);
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
                      AppLocalizations.of(context)!.chatPreferencesTextColor,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: Text(
                    AppLocalizations.of(context)!.chatPreferencesLightTheme),
                value: !isDarkTheme,
                onChanged: (bool? value) async {
                  if (value != null && value) {
                    await SettingsPreferences.setDarkMode(false);
                    setState(() {
                      isDarkTheme = false;
                    });
                  }
                },
              ),
              CheckboxListTile(
                title:
                    Text(AppLocalizations.of(context)!.chatPreferencesDarkTheme),
                value: isDarkTheme,
                onChanged: (bool? value) async {
                  if (value != null && value) {
                    await SettingsPreferences.setDarkMode(true);
                    setState(() {
                      isDarkTheme = true;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
