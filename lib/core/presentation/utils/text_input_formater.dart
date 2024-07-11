import 'package:flutter/services.dart';

class TextInputFormater extends TextInputFormatter {
  final RegExp regExp;

  TextInputFormater(this.regExp);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    if (regExp.hasMatch(newText)) {
      return newValue;
    }
    return oldValue;
  }
}
