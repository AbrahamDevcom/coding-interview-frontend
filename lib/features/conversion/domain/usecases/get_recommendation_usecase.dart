import '../entities/amount.dart';
import '../entities/exchange_rate.dart';
import '../repositories/conversion_repository.dart';

class GetRecommendationUseCase {
  final ConversionRepository _repo;

  GetRecommendationUseCase(this._repo);

  Future<ExchangeRate> execute({
    required Amount input,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required int type,
  }) {
    return _repo.getExchangeRate(
      input: input,
      cryptoCurrencyId: cryptoCurrencyId,
      fiatCurrencyId: fiatCurrencyId,
      type: type,
    );
  }
}
