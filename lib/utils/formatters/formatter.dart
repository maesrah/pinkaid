import 'package:intl/intl.dart';

class KFormatter {
  static String formateDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyy').format(date);
  }

  static String formateCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_MY', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 9) {
      return '(${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5)})';
    } else if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)})';
    }
    return phoneNumber;
  }
}
