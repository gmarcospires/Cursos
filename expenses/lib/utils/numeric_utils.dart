import 'package:intl/intl.dart';

class NumericUtils {
  static String fortmatCurrency(double value) {
    return NumberFormat.simpleCurrency(locale: 'pt_BR').format(value);
  }

  static String formatPercentage(double value, {int decimalDigits = 2}) {
    return NumberFormat.decimalPercentPattern(decimalDigits: decimalDigits)
        .format(value);
  }

  static String formatDecimal(double value) {
    return NumberFormat.decimalPattern().format(value);
  }
}
