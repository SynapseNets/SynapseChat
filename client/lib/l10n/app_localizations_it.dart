import 'app_localizations.dart';

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get homepage_title => 'Benvenuto in SynapseChat';

  @override
  String get homepage_description => 'Il servizio di messaggistica più sicuro al mondo';

  @override
  String get homepage_selectLanguage => 'Seleziona la lingua';

  @override
  String get homepage_continue => 'Continua';

  @override
  String get homepage_options => 'Opzioni';

  @override
  String get loginPage_title => 'Accesso';

  @override
  String get loginPage_description => 'Accedi a SynapseChat';

  @override
  String get loginPage_remeberMe => 'Ricordami';

  @override
  String get loginPage_signUp => 'Registrati';

  @override
  String get loginPage_Login => 'Accedi';

  @override
  String get registrationPage_title => 'Registrazione';

  @override
  String get registrationPage_description => 'Registrati a SynapseChat';

  @override
  String get registrationPage_repeatPw => 'Ripeti Password';

  @override
  String get registrationPage_registration => 'Registrati';
}
