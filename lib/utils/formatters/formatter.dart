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
    phoneNumber = '+60$phoneNumber';
    return phoneNumber;
  }
}
