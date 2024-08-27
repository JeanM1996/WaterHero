import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LangEn extends Lang {
  LangEn([String locale = 'en']) : super(locale);

  @override
  String get noInternet => 'No internet connection';

  @override
  String get noInternetMessage => 'Please check your internet connection';

  @override
  String get ok => 'OK';

  @override
  String get weArePresentingFailures => 'We are presenting failures';

  @override
  String get weArePresentingFailuresMessage => 'Please try again later';

  @override
  String get tryAgain => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get login => 'Log in';

  @override
  String get loginWelcome => 'Welcome, log in to continue';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get register => 'Register';

  @override
  String get errorOnLogin => 'Error on login';

  @override
  String get errorOnLoginMessage => 'Please check your email and password';

  @override
  String get userDisabled => 'User disabled';

  @override
  String get userDisabledMessage => 'Please contact the administrator';

  @override
  String get wrongCredentials => 'Wrong credentials';

  @override
  String get registerMessage => 'Please fill in the fields to register';

  @override
  String get name => 'Name';

  @override
  String get lastName => 'Last name';

  @override
  String get registerVerb => 'Register';

  @override
  String get forgotMyPassword => 'I forgot my password';

  @override
  String get forgotMyPasswordMessage => 'Please enter your email to reset your password';

  @override
  String get send => 'Send';

  @override
  String get serviceCode => 'Service code';

  @override
  String get emailSent => 'Email sent';

  @override
  String get emailSentMessage => 'An email has been sent with instructions to reset your password';

  @override
  String get loadingWeather => 'Loading weather';

  @override
  String get exceedExpectedConsumption => 'You will exceed your expected consumption';

  @override
  String get exceedExpectedConsumptionMessage => 'Take care of your shower time!';

  @override
  String get youAreSavingWater => 'You are saving water';

  @override
  String get youAreSavingWaterMessage => 'Keep it up!';

  @override
  String get projectedConsumption => 'Projected consumption';

  @override
  String get showerTime => 'Shower time';

  @override
  String get dailyConsumption => 'Daily consumption';

  @override
  String get helpAndFollowTheAdvices => 'Help us and follow the advice';

  @override
  String get togetherWeCanSave => 'Together we can save';

  @override
  String get logOut => 'Log out';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get lastRegisterOf => 'Last register of';

  @override
  String get cubicMeters => 'cubic meters';

  @override
  String get at => 'at';
}
