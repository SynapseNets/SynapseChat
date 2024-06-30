import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homepage_title => 'Welcome to SynapseChat';

  @override
  String get homepage_description => 'The most secure messaging service available';

  @override
  String get homepage_selectLanguage => 'Select your langauge';

  @override
  String get homepage_continue => 'Continue';

  @override
  String get homepage_options => 'Options';

  @override
  String get loginPage_title => 'Login';

  @override
  String get loginPage_description => 'Login to SynapseChat';

  @override
  String get loginPage_remeberMe => 'Remember me';

  @override
  String get loginPage_signUp => 'Sign Up';

  @override
  String get loginPage_Login => 'Login';
}
