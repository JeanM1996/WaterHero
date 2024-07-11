import 'package:intl/intl.dart';

extension NumExtension on num {
  String toFormattedCurrency() {
    return NumberFormat.currency(locale: 'es_CO', symbol: '').format(this);
  }

  //round double values to 2 decimals
  double roundDouble() {
    return double.parse(toStringAsFixed(2));
  }

  //formated with dollar sign
  String toFormattedCurrencyWithDollar() {
    return NumberFormat.currency(
            //-$1.000.007.990
            locale: 'es_CO',
            symbol: '\$',
            customPattern: '\u00A4 #,##0.00')
        .format(this);
  }
}
