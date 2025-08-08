import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/currency_model.dart';

class CurrencySelectionState {
  final CurrencyModel? fromCurrency;
  final CurrencyModel? toCurrency;

  const CurrencySelectionState({
    this.fromCurrency,
    this.toCurrency,
  });

  CurrencySelectionState copyWith({
    CurrencyModel? fromCurrency,
    CurrencyModel? toCurrency,
  }) {
    return CurrencySelectionState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
    );
  }
}

class CurrencySelectionNotifier extends StateNotifier<CurrencySelectionState> {
  CurrencySelectionNotifier() : super(CurrencySelectionState(
    fromCurrency: CurrencyData.cryptoCurrencies.first,
    toCurrency: CurrencyData.fiatCurrencies.first,
  ));

  void selectFromCurrency(CurrencyModel currency) {
    state = state.copyWith(fromCurrency: currency);
  }

  void selectToCurrency(CurrencyModel currency) {
    state = state.copyWith(toCurrency: currency);
  }

  void swapCurrencies() {
    state = CurrencySelectionState(
      fromCurrency: state.toCurrency,
      toCurrency: state.fromCurrency,
    );
  }

  List<CurrencyModel> getAvailableCurrencies(CurrencyType type) {
    return CurrencyData.getCurrenciesByType(type);
  }
}