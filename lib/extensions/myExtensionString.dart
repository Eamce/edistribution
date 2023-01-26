import 'package:intl/intl.dart';

extension MyExtensionString on String {
  String get toCurrencyFormat {
    return NumberFormat.currency(locale: 'en', symbol: '₱ ')
        .format(double.parse(this));
  }
}
