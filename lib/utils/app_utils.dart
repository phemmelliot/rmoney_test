import 'package:intl/intl.dart';

class AppUtils {
  static String formatCurrency(num amount) {
    return NumberFormat.currency(symbol: "₦").format(amount);
  }
}