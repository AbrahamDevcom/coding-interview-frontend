class ExchangeRate {
  final double rate;
  final String baseCurrencyId;
  final String quoteCurrencyId;
  final double? estimatedTimeMinutes;

  ExchangeRate({
    required this.rate,
    required this.baseCurrencyId,
    required this.quoteCurrencyId,
    this.estimatedTimeMinutes,
  });
}
