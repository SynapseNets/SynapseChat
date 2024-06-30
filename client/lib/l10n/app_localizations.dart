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

  /// No description provided for @homepage_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SynapseChat'**
  String get homepage_title;

  /// No description provided for @homepage_description.
  ///
  /// In en, this message translates to:
  /// **'The most secure messaging service available'**
  String get homepage_description;

  /// No description provided for @homepage_selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your langauge'**
  String get homepage_selectLanguage;

  /// No description provided for @homepage_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get homepage_continue;

  /// No description provided for @homepage_options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get homepage_options;

  /// No description provided for @loginPage_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginPage_title;

  /// No description provided for @loginPage_description.
  ///
  /// In en, this message translates to:
  /// **'Login to SynapseChat'**
  String get loginPage_description;

  /// No description provided for @loginPage_remeberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get loginPage_remeberMe;

  /// No description provided for @loginPage_signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get loginPage_signUp;

  /// No description provided for @loginPage_Login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginPage_Login;

  /// No description provided for @registrationPage_title.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registrationPage_title;

  /// No description provided for @registrationPage_description.
  ///
  /// In en, this message translates to:
  /// **'Signup to SynapseChat'**
  String get registrationPage_description;

  /// No description provided for @registrationPage_repeatPw.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get registrationPage_repeatPw;

  /// No description provided for @registrationPage_registration.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registrationPage_registration;
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
