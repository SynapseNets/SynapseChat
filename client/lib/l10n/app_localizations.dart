import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('it')
  ];

  /// No description provided for @homepageTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SynapseChat'**
  String get homepageTitle;

  /// No description provided for @homepageDescription.
  ///
  /// In en, this message translates to:
  /// **'The most secure messaging service available'**
  String get homepageDescription;

  /// No description provided for @homepageSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your language'**
  String get homepageSelectLanguage;

  /// No description provided for @homepageContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get homepageContinue;

  /// No description provided for @homepageOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get homepageOptions;

  /// No description provided for @loginPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginPageTitle;

  /// No description provided for @loginPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Login to SynapseChat'**
  String get loginPageDescription;

  /// No description provided for @loginPageRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get loginPageRememberMe;

  /// No description provided for @loginPageSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get loginPageSignUp;

  /// No description provided for @loginPageLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginPageLogin;

  /// No description provided for @loginPageSnackbarError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect username or password'**
  String get loginPageSnackbarError;

  /// No description provided for @registrationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registrationPageTitle;

  /// No description provided for @registrationPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Signup to SynapseChat'**
  String get registrationPageDescription;

  /// No description provided for @registrationPageRepeatPw.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get registrationPageRepeatPw;

  /// No description provided for @registrationPageRegistration.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registrationPageRegistration;

  /// No description provided for @registrationPageUsernameError.
  ///
  /// In en, this message translates to:
  /// **'Username must not be empty'**
  String get registrationPageUsernameError;

  /// No description provided for @registrationPageFirstPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be 8 characters long\n with numbers and special characters'**
  String get registrationPageFirstPasswordError;

  /// No description provided for @registrationPageSecondPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get registrationPageSecondPasswordError;

  /// No description provided for @registrationPageSnackbarError.
  ///
  /// In en, this message translates to:
  /// **'Access denied: Correct the errors in the fields above'**
  String get registrationPageSnackbarError;

  /// No description provided for @contentPageSelectChatText.
  ///
  /// In en, this message translates to:
  /// **'Select a chat to start messaging'**
  String get contentPageSelectChatText;

  /// No description provided for @serverConnectPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect to a server'**
  String get serverConnectPageTitle;

  /// No description provided for @serverConnectPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect to a new server'**
  String get serverConnectPageDescription;

  /// No description provided for @serverConnectPageIp.
  ///
  /// In en, this message translates to:
  /// **'Server IP'**
  String get serverConnectPageIp;

  /// No description provided for @serverConnectPageConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get serverConnectPageConnect;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @settingsPageUsername.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get settingsPageUsername;

  /// No description provided for @settingsPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get settingsPageDescription;

  /// No description provided for @settingsPageChatSettings.
  ///
  /// In en, this message translates to:
  /// **'Chat settings'**
  String get settingsPageChatSettings;

  /// No description provided for @settingsPageLanguages.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsPageLanguages;

  /// No description provided for @settingsPageCredits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get settingsPageCredits;

  /// No description provided for @profilePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profilePageTitle;

  /// No description provided for @profilePageChangePicture.
  ///
  /// In en, this message translates to:
  /// **'Change profile picture'**
  String get profilePageChangePicture;

  /// No description provided for @profilePageName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profilePageName;

  /// No description provided for @profilePageDescriptionName.
  ///
  /// In en, this message translates to:
  /// **'This is the name your contacts will see \nIs not related to your login username'**
  String get profilePageDescriptionName;

  /// No description provided for @profilePageBiography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get profilePageBiography;

  /// No description provided for @profilePageDescriptionBiography.
  ///
  /// In en, this message translates to:
  /// **'Describe yourself briefly'**
  String get profilePageDescriptionBiography;

  /// No description provided for @chatPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat Settings'**
  String get chatPreferencesTitle;

  /// No description provided for @chatPreferencesFontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get chatPreferencesFontSize;

  /// No description provided for @chatPreferencesFirstText.
  ///
  /// In en, this message translates to:
  /// **'Hi there!'**
  String get chatPreferencesFirstText;

  /// No description provided for @chatPreferencesSecondText.
  ///
  /// In en, this message translates to:
  /// **'Hello! How are you?'**
  String get chatPreferencesSecondText;

  /// No description provided for @chatPreferencesThirdText.
  ///
  /// In en, this message translates to:
  /// **'I\'m good, thanks! And you?'**
  String get chatPreferencesThirdText;

  /// No description provided for @chatPreferencesBackground.
  ///
  /// In en, this message translates to:
  /// **'Change Background Color'**
  String get chatPreferencesBackground;

  /// No description provided for @chatPreferencesTextDialogBackground.
  ///
  /// In en, this message translates to:
  /// **'Choose Background Color'**
  String get chatPreferencesTextDialogBackground;

  /// No description provided for @chatPreferencesTextColor.
  ///
  /// In en, this message translates to:
  /// **'Change Text Color'**
  String get chatPreferencesTextColor;

  /// No description provided for @chatPreferencesTextDialogColor.
  ///
  /// In en, this message translates to:
  /// **'Choose Text Color'**
  String get chatPreferencesTextDialogColor;

  /// No description provided for @chatPreferencesLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get chatPreferencesLightTheme;

  /// No description provided for @chatPreferencesDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get chatPreferencesDarkTheme;

  /// No description provided for @languagesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languagesPageTitle;

  /// No description provided for @creditsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get creditsPageTitle;

  /// No description provided for @creditsPageDescription.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get creditsPageDescription;

  /// No description provided for @creditsPageDeveloperCreditsButton.
  ///
  /// In en, this message translates to:
  /// **'Developers credits'**
  String get creditsPageDeveloperCreditsButton;

  /// No description provided for @creditsPageIconsCreditsButton.
  ///
  /// In en, this message translates to:
  /// **'Icons credits'**
  String get creditsPageIconsCreditsButton;

  /// No description provided for @developerscreditsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Developers Credits'**
  String get developerscreditsPageTitle;

  /// No description provided for @developerscreditsPageDescriptionAlBovo.
  ///
  /// In en, this message translates to:
  /// **'Server-side development'**
  String get developerscreditsPageDescriptionAlBovo;

  /// No description provided for @developerscreditsPageDescriptionMark74.
  ///
  /// In en, this message translates to:
  /// **'Frontend and client-side backend development'**
  String get developerscreditsPageDescriptionMark74;

  /// No description provided for @developerscreditsPageDescriptionMattiaCincotta.
  ///
  /// In en, this message translates to:
  /// **'Frontend development'**
  String get developerscreditsPageDescriptionMattiaCincotta;

  /// No description provided for @developerscreditsPageDescriptionLorii0.
  ///
  /// In en, this message translates to:
  /// **'Frontend development'**
  String get developerscreditsPageDescriptionLorii0;

  /// No description provided for @developerscreditsPageDescriptionAntostarwars.
  ///
  /// In en, this message translates to:
  /// **'Frontend and client-side backend development'**
  String get developerscreditsPageDescriptionAntostarwars;

  /// No description provided for @iconscreditsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Icons Credits'**
  String get iconscreditsPageTitle;

  /// No description provided for @iconscreditsPageInfoIcon.
  ///
  /// In en, this message translates to:
  /// **'  Info icon created by Anggara - Flaticon'**
  String get iconscreditsPageInfoIcon;

  /// No description provided for @iconscreditsPageMessageIcon.
  ///
  /// In en, this message translates to:
  /// **'   Message icon created by Fathema Khanom - Flaticon'**
  String get iconscreditsPageMessageIcon;

  /// No description provided for @iconscreditsPageGalleryIcon.
  ///
  /// In en, this message translates to:
  /// **'   Gallery icon created by adrianadam - Flaticon'**
  String get iconscreditsPageGalleryIcon;

  /// No description provided for @iconscreditsPageAddDatabaseIcon.
  ///
  /// In en, this message translates to:
  /// **'   Add database icon created by Arafat Uddin - Flaticon'**
  String get iconscreditsPageAddDatabaseIcon;

  /// No description provided for @iconscreditsPageProfileImageIcon.
  ///
  /// In en, this message translates to:
  /// **'   Profile image icon created by Md Tanvirul Haque - Flaticon'**
  String get iconscreditsPageProfileImageIcon;

  /// No description provided for @iconscreditsPageUserIcon.
  ///
  /// In en, this message translates to:
  /// **'   User icons created by Freepik - Flaticon'**
  String get iconscreditsPageUserIcon;

  /// No description provided for @iconscreditsPageEarthGlobeIcon.
  ///
  /// In en, this message translates to:
  /// **'   Earth globe icon created by Freepik - Flaticon'**
  String get iconscreditsPageEarthGlobeIcon;

  /// No description provided for @contentPageTextbar.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get contentPageTextbar;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
