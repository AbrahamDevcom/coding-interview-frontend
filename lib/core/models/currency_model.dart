class CurrencyModel {
  final String code;
  final String id;
  final String name;
  final String fullName;
  final CurrencyType type;
  final String flagAsset;
  final String symbol;

  const CurrencyModel({
    required this.code,
    required this.id,
    required this.name,
    required this.fullName,
    required this.type,
    required this.flagAsset,
    required this.symbol,
  });
}

enum CurrencyType { fiat, crypto }

class CurrencyData {
  static const List<CurrencyModel> fiatCurrencies = [
    CurrencyModel(
      code: 'VES',
      id: 'VES',
      name: 'Bolívares',
      fullName: 'Bolívares (Bs)',
      type: CurrencyType.fiat,
      flagAsset: 'assets/fiat_currencies/VES.png',
      symbol: 'Bs',
    ),
    CurrencyModel(
      code: 'COP',
      id: 'COP',
      name: 'Pesos Colombianos',
      fullName: 'Pesos Colombianos (COL\$)',
      type: CurrencyType.fiat,
      flagAsset: 'assets/fiat_currencies/COP.png',
      symbol: 'COL\$',
    ),
    CurrencyModel(
      code: 'PEN',
      id: 'PEN',
      name: 'Soles Peruanos',
      fullName: 'Soles Peruanos (S/)',
      type: CurrencyType.fiat,
      flagAsset: 'assets/fiat_currencies/PEN.png',
      symbol: 'S/',
    ),
    CurrencyModel(
      code: 'BRL',
      id: 'BRL',
      name: 'Real Brasileño',
      fullName: 'Real Brasileño (R\$)',
      type: CurrencyType.fiat,
      flagAsset: 'assets/fiat_currencies/BRL.png',
      symbol: 'R\$',
    ),
  ];

  static const List<CurrencyModel> cryptoCurrencies = [
    CurrencyModel(
      code: 'USDT',
      id: 'TATUM-TRON-USDT',
      name: 'USDT',
      fullName: 'Tether USD (USDT)',
      type: CurrencyType.crypto,
      flagAsset: 'assets/cripto_currencies/TATUM-TRON-USDT.png',
      symbol: '\$',
    ),
  ];

  static List<CurrencyModel> getCurrenciesByType(CurrencyType type) {
    return type == CurrencyType.fiat ? fiatCurrencies : cryptoCurrencies;
  }
}
