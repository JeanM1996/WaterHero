import 'lang.dart';

/// The translations for Spanish Castilian (`es`).
class LangEs extends Lang {
  LangEs([String locale = 'es']) : super(locale);

  @override
  String get noInternet => 'No hay conexión a internet';

  @override
  String get noInternetMessage => 'Por favor, compruebe su conexión a internet';

  @override
  String get ok => 'OK';

  @override
  String get weArePresentingFailures => 'Estamos presentando fallas';

  @override
  String get weArePresentingFailuresMessage => 'Por favor, inténtelo de nuevo más tarde';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get loginWelcome => 'Bienvenido, inicie sesión para continuar';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get register => 'Registrarse';

  @override
  String get errorOnLogin => 'Error al iniciar sesión';

  @override
  String get errorOnLoginMessage => 'Por favor, compruebe su correo electrónico y contraseña';

  @override
  String get userDisabled => 'Usuario deshabilitado';

  @override
  String get userDisabledMessage => 'Por favor, póngase en contacto con el administrador';

  @override
  String get wrongCredentials => 'Credenciales incorrectas';

  @override
  String get registerMessage => 'Por favor, complete los campos para registrarse';

  @override
  String get name => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get registerVerb => 'Registrarse';

  @override
  String get forgotMyPassword => 'Olvidé mi contraseña';

  @override
  String get forgotMyPasswordMessage => 'Por favor, introduzca su correo electrónico para restablecer su contraseña';

  @override
  String get send => 'Enviar';

  @override
  String get serviceCode => 'Código de servicio';

  @override
  String get emailSent => 'Correo electrónico enviado';

  @override
  String get emailSentMessage => 'Se ha enviado un correo electrónico con instrucciones para restablecer su contraseña';

  @override
  String get loadingWeather => 'Cargando clima';

  @override
  String get exceedExpectedConsumption => 'Excederás tu consumo esperado';

  @override
  String get exceedExpectedConsumptionMessage => '¡Cuida tu tiempo en la ducha!';

  @override
  String get youAreSavingWater => 'Estás ahorrando agua';

  @override
  String get youAreSavingWaterMessage => '¡Sigue así!';

  @override
  String get projectedConsumption => 'Consumo proyectado';

  @override
  String get showerTime => 'Tiempo en ducha';

  @override
  String get dailyConsumption => 'Consumo por día';
}
