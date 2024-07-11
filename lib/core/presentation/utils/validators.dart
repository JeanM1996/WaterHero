final RegExp _emailRegExp = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);
String? validateEmail(String email, bool isRequired, {String? matchValue}) {
  if (email.isEmpty && isRequired) {
    return 'Introduce un correo electrónico';
  } else if (email.isEmpty && !isRequired) {
    return null;
  } else if (!_emailRegExp.hasMatch(email.trim())) {
    return 'Por favor introduce un correo válido';
  }

  /// Si es un campo de repetición
  if (matchValue != null) {
    return validateMatchValue(email, matchValue);
  }

  return null;
}

String? validatePassword(String input, {String? matchValue}) {
  if (input.trim().length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  } else {
    //6 caracteres y almenos un numero
    const pattern = r'^(?=.*[0-9]).{6,}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Debe contener al menos 6 caracteres y un número';
    }
  }

  /// Si es un campo de repetición
  if (matchValue != null) {
    return validateMatchValue(input, matchValue);
  }
  return null;
}

String? validateIsNotEmpty(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validateText(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    const pattern = r'^[a-zA-Z\s]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Ingresa un nombre válido';
    }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validateNumber(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Valor obligatorio';
  } else {
    //mayor a 0
    const pattern = r'^[1-9][0-9]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Valor no válido';
    }

    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validatePercentage(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Valor obligatorio';
  } else {
    //percentage between 1 and 100 with 2
    //decimals with dot r'^[0-9]{1,2}([,][0-9]{1,2})?$|^100([.]0{1,2})?$';
    const pattern = r'^([0-9][0-9]?|100)(\,[0-9]{1,2})?$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Porcentaje no válido';
    }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validateStreet(String input, {String? matchValue}) {
  //symbols numbers and letters
  final regex = RegExp(r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]*$');
  if (input.isEmpty) {
    return 'Ingresa un valor';
    //mayor a 1
  } else if (input.isEmpty || input == '0') {
    return 'El campo debe tener más de un carácter';
  } else if (!regex.hasMatch(input)) {
    return 'La cadena contiene caracteres no permitidos';
  }

  /// Si es un campo de repetición
  if (matchValue != null) {
    return validateMatchValue(input, matchValue);
  }
  return null;
}

//String alphanumeric
String? validateAlphanumeric(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    //with spaces numbers and letters
    const pattern = r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Sin caracteres especiales';
    }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

//String alphanumeric
String? validateAlphanumericDot(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    //with spaces numbers and letters and : .
    const pattern = r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s:.]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Sin caracteres especiales';
    }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

//String alphanumericChars
String? validateAlphanumeric50(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    //with spaces numbers and letters
    const pattern = r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Sin caracteres especiales';
    } else if (input.length > 50) {
      return 'Ingresa un máximo de 50  caracteres';
    }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validateAlphanumeric28(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    //with spaces numbers and letters
    const pattern = r'^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚüÜ\s]*$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Sin caracteres especiales';
    } else if (input.length > 28) {
      return 'Ingresa un máximo de 50  caracteres';
    }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validateName(String? input) {
  if ((input ?? '').isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    if (input!.length > 1) {
      const pattern =
          r'^[a-zA-ZÀ-ÿ\u00f1\u00d1]*(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]*$';
      final regExp = RegExp(pattern);
      if (!regExp.hasMatch(input)) {
        return 'Ingresa un nombre válido';
      }
    } else {
      return 'El nombre debe tener más de un carácter';
    }

    return null;
  }
}

String? validatePlace(String? input) {
  if ((input ?? '').isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    if (input!.length > 1) {
      const pattern =
          r'^[a-zA-ZÀ-ÿ\u00f1\u00d1]*(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]*$';
      final regExp = RegExp(pattern);
      if (!regExp.hasMatch(input)) {
        return 'Ingresa un nombre de barrio válido';
      }
    } else {
      return 'El nombre de barrio debe tener más de un carácter';
    }

    return null;
  }
}

String? validateCode({required String input, required bool errorBack}) {
  if (input.trim().length < 4) {
    return 'Debes ingresar el codigo recibido';
  }
  if (errorBack) {
    return 'El código es incorrecto';
  }
  return null;
}

String? validateLastName(String? input) {
  if ((input ?? '').isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    if (input!.length > 1) {
      const pattern =
          r'^[a-zA-ZÀ-ÿ\u00f1\u00d1]*(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]*$';
      final regExp = RegExp(pattern);
      if (!regExp.hasMatch(input)) {
        return 'Ingresa un apellido válido';
      }
    } else {
      return 'El apellido debe tener más de un carácter';
    }

    return null;
  }
}

String? validatePhone(String input, {String? matchValue}) {
  //validate if has more than 5
  if (input.length < 10) {
    return 'Introduce un número de celular válido';
  }

  /// Si es un campo de repetición
  if (matchValue != null) {
    return validateMatchValue(input, matchValue);
  }
  return null;
}

String? validateDocument(String input) {
  if (input.trim() == '') {
    return 'Escribe tu número de cédula';
  }
  if (input.length < 6) {
    return 'Ingresa mínimo 6 caracteres';
  } else if (input.length > 20) {
    return 'Ingresa máximo 20 caracteres';
  } else {
    //without spaces and letters
    const pattern = r'^[a-zA-Z0-9\s]{5,20}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Ingresa un número de identificación válido';
    }
  }

  return null;
}

String? validatePassport(String input) {
  if (input.trim() == '') {
    return 'Escribe tu número de pasaporte';
  }
  if (input.length < 5) {
    return 'Ingresa mínimo 5 caracteres';
  } else if (input.length > 15) {
    return 'Ingresa máximo 15 caracteres';
  } else {
    //max 15 characters without simbols only letters and numbers
    const pattern = r'^[a-zA-Z0-9\s]{5,15}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Ingresa un número de pasaporte válido';
    }
  }

  return null;
}

String? validateCE(String input) {
  if (input.trim() == '') {
    return 'Escribe tu número de cédula';
  }
  if (input.length < 6) {
    return 'El número de cédula debe tener 6 dígitos';
  } else {
    const pattern = r'^[0-9\s]{0,10}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Ingresa un número de cédula válido';
    }
  }

  return null;
}

String? validateNIT(String input) {
  if (input.trim() == '') {
    return 'Escribe tu número de cédula';
  }
  if (input.length < 9) {
    return 'El número de cédula debe tener más de 9 dígitos';
  } else {
    const pattern = r'^[0-9\s]{0,10}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Ingresa un número de cédula válido';
    }
  }

  return null;
}

String? validateCurrency(String input) {
  if (input.trim() == '') {
    return 'Escribe el valor';
  }
  if (input.isEmpty) {
    return 'El valor debe tener más de 1 dígito';
  } else {
    const pattern = r'^[0-9.,\s]{1,500}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input) || input == '0,00') {
      return 'El valor debe ser mayor a 0';
    }
  }

  return null;
}

String? allowCurrencyZero(String input) {
  if (input.trim() == '') {
    return 'Escribe el valor';
  }
  if (input.isEmpty) {
    return 'El valor debe tener más de 1 dígito';
  } else {
    const pattern = r'^[0-9.,\s]{1,500}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(input)) {
      return 'Escribe un valor válido';
    }
  }

  return null;
}

String? noValidate() => null;

String? noValidate2(String input) {
  if (input.trim() == '') {
    return 'Este campo es obligatorio';
  }
  return null;
}

String? validateMatchValue(
  String value,
  String match,
) =>
    value != match ? 'Las contraseñas no coinciden' : null;
