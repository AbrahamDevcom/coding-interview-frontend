import '../entities/amount.dart';
import '../entities/exchange_rate.dart';

abstract class ConversionRepository {
  Future<ExchangeRate> getExchangeRate({
    required Amount input,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required int type,
  });
}
