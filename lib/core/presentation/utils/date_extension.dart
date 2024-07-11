import 'package:intl/intl.dart';
import 'package:waterhero/core/presentation/utils/string_extension.dart';

extension DateExtension on DateTime {
  String toFormattedDate() {
    return DateFormat.yMd().format(this);
  }

  String toFormattedTimeAgo() {
    final time = add(const Duration());
    final difference = DateTime.now().difference(time);
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'día' : 'días'}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hora' : 'horas'}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minuto' : 'minutos'}';
    } else {
      return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'segundo' : 'segundos'}';
    }
  }

  //dd/MM/yyyy (center-dot) hh:mm AM/PM
  String toFormattedDateTime() {
    //final now = DateTime.now();
    //now.timeZoneOffset.inHours;
    const localHours = -5;

    return DateFormat('dd/MM/yyyy \u00B7 hh:mm a')
        .format(add(const Duration(hours: localHours)));
  }

  String onlyHoutAMPM() {
    return DateFormat('hh:mm a').format(this);
  }

  /// 07 dic, 2022 format
  String toFormattedDateWithMonth() {
    return DateFormat.yMMMd('es').format(this);
  }

  String toFormattedDateWithMonthName() {
    return DateFormat.yMMMMd('es').format(this);
  }

  //"dateQuota": "2023-09-01",
  String toFormatAAMMDD() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  //"dateQuota": "2023_09_01_00_00_00",
  String toFormatAAMMDDHHMMSS() {
    return DateFormat('yyyy_MM_dd_HH_mm_ss').format(this);
  }

  String toFormatAAMMDDHHMMSS2() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  String toFormatDDMMYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  //17/Mayo
  String toFormatDDMM() {
    return DateFormat('dd MMMM', 'es').format(this);
  }

  // 17 May 2024
  String toFormatDDMMMYYYY() {
    return DateFormat('dd MMM yyyy', 'es').format(this);
  }

  //Mie 6, Dic - 2022 //bale informative
  String toFormatDDMMMYYYY2() {
    return DateFormat('EEE d, MMM - yyyy', 'es').format(this);
  }

  //Jueves 04 Agosto, 2023 / 9:00 am :  Reportes
  String toFormatDDMMMYYYY3() {
    return DateFormat('EEEE dd MMMM, yyyy / hh:mm a', 'es')
        .format(this)
        .capitalize();
  }

  String toFormatDDMMMYYYYLocal() {
    //final now = DateTime.now();

    const localHours = -5;
    return DateFormat('EEEE dd MMMM, yyyy / hh:mm a', 'es')
        .format(add(const Duration(hours: localHours)))
        .capitalize();
  }

  //Mie 19, Jul : informative some sections
  String toFormatDDMMM() {
    return DateFormat('EEE d, MMM', 'es').format(this);
  }

  //01 dic. 2022 - 8:00 am : payment form
  String toFormatDDMMMYYYY4() {
    return DateFormat('dd MMM. yyyy - hh:mm a', 'es').format(this);
  }

  //Date to mothn name
  String toMonthNameYear() {
    return DateFormat('MMMM yyyy', 'es').format(this).capitalizeFirstWord();
  }

  DateTime addMonths(int months) {
    return DateTime(year, month + months, day);
  }

  //2024-02-26 12:22:22.373046
  String toFormatAAMMDDHHMMSS3() {
    return DateFormat('yyyy-MM-dd HH:mm:ss.S').format(this);
  }

  int daysForTheFirstDayNextMonth() {
    final nextMonth = addMonths(1);
    final actual = DateTime.now();
    //get the first day of the next month
    final firstDayNextMonth = DateTime(nextMonth.year, nextMonth.month);
    final difference = firstDayNextMonth.difference(actual);

    return difference.inDays;
  }

  String toNanoSecondsSinceEpoch() {
    // Get the current time in milliseconds since Unix epoch
    final millisecondsSinceEpoch = this.millisecondsSinceEpoch;

    // Convert milliseconds to nanoseconds
    final nanosecondsSinceEpoch = millisecondsSinceEpoch * 1000000;

    return nanosecondsSinceEpoch.toString();
  }
}
