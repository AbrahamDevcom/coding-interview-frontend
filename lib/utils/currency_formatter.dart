import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatAmount(double amount, String currencyCode) {
    switch (currencyCode) {
      case 'VES':
        return '${NumberFormat('#,##0', 'es_VE').format(amount)} $currencyCode';

      case 'COP':
        return '${NumberFormat('#,##0', 'es_CO').format(amount)} $currencyCode';

      case 'PEN':
        return '${NumberFormat('#,##0.00', 'es_PE').format(amount)} $currencyCode';

      case 'BRL':
        return '${NumberFormat('#,##0.00', 'pt_BR').format(amount)} $currencyCode';

      case 'USDT':
        return '${NumberFormat('#,##0.00', 'en_US').format(amount)} $currencyCode';

      default:
        return '${NumberFormat('#,##0.00').format(amount)} $currencyCode';
    }
  }

  static String formatRate(
    double rate,
    String fromCurrency,
    String toCurrency,
  ) {
    final formattedRate = formatAmount(rate, toCurrency);
    return formattedRate;
  }

}
