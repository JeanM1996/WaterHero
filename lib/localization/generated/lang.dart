import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'lang_es.dart';

/// Callers can lookup localized strings with an instance of Lang
/// returned by `Lang.of(context)`.
///
/// Applications need to include `Lang.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/lang.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Lang.localizationsDelegates,
///   supportedLocales: Lang.supportedLocales,
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
/// be consistent with the languages listed in the Lang.supportedLocales
/// property.
abstract class Lang {
  Lang(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Lang of(BuildContext context) {
    return Localizations.of<Lang>(context, Lang)!;
  }

  static const LocalizationsDelegate<Lang> delegate = _LangDelegate();

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
    Locale('es')
  ];

  /// No description provided for @noInternet.
  ///
  /// In es, this message translates to:
  /// **'No hay conexión a internet'**
  String get noInternet;

  /// No description provided for @noInternetMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, compruebe su conexión a internet'**
  String get noInternetMessage;

  /// No description provided for @ok.
  ///
  /// In es, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @weArePresentingFailures.
  ///
  /// In es, this message translates to:
  /// **'Estamos presentando fallas'**
  String get weArePresentingFailures;

  /// No description provided for @weArePresentingFailuresMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, inténtelo de nuevo más tarde'**
  String get weArePresentingFailuresMessage;

  /// No description provided for @tryAgain.
  ///
  /// In es, this message translates to:
  /// **'Intentar de nuevo'**
  String get tryAgain;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @loginWelcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido, inicie sesión para continuar'**
  String get loginWelcome;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get register;

  /// No description provided for @errorOnLogin.
  ///
  /// In es, this message translates to:
  /// **'Error al iniciar sesión'**
  String get errorOnLogin;

  /// No description provided for @errorOnLoginMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, compruebe su correo electrónico y contraseña'**
  String get errorOnLoginMessage;

  /// No description provided for @userDisabled.
  ///
  /// In es, this message translates to:
  /// **'Usuario deshabilitado'**
  String get userDisabled;

  /// No description provided for @userDisabledMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, póngase en contacto con el administrador'**
  String get userDisabledMessage;

  /// No description provided for @wrongCredentials.
  ///
  /// In es, this message translates to:
  /// **'Credenciales incorrectas'**
  String get wrongCredentials;

  /// No description provided for @registerMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, complete los campos para registrarse'**
  String get registerMessage;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @lastName.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get lastName;

  /// No description provided for @registerVerb.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registerVerb;

  /// No description provided for @forgotMyPassword.
  ///
  /// In es, this message translates to:
  /// **'Olvidé mi contraseña'**
  String get forgotMyPassword;

  /// No description provided for @forgotMyPasswordMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduzca su correo electrónico para restablecer su contraseña'**
  String get forgotMyPasswordMessage;

  /// No description provided for @send.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get send;

  /// No description provided for @serviceCode.
  ///
  /// In es, this message translates to:
  /// **'Código de servicio'**
  String get serviceCode;
}

class _LangDelegate extends LocalizationsDelegate<Lang> {
  const _LangDelegate();

  @override
  Future<Lang> load(Locale locale) {
    return SynchronousFuture<Lang>(lookupLang(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_LangDelegate old) => false;
}

Lang lookupLang(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return LangEs();
  }

  throw FlutterError(
    'Lang.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
