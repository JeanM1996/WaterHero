import 'package:intl/intl.dart';

extension DoubleExtension on double {
  //format 2.000.000,00

  String formatCurrency() {
    final formatter = NumberFormat.currency(locale: 'es_CO', symbol: '');
    return formatter.format(this);
  }
}
