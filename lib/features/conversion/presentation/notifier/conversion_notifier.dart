import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/amount.dart';
import '../../domain/entities/exchange_rate.dart';
import '../../domain/usecases/get_recommendation_usecase.dart';

class ConversionState {
  final ExchangeRate? exchangeRate;
  final bool isLoading;
  final String? errorMessage;

  const ConversionState({
    this.exchangeRate,
    this.isLoading = false,
    this.errorMessage,
  });

  ConversionState copyWith({
    ExchangeRate? exchangeRate,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ConversionState(
      exchangeRate: exchangeRate ?? this.exchangeRate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ConversionNotifier extends StateNotifier<ConversionState> {
  final GetRecommendationUseCase _getRecommendationUseCase;

  ConversionNotifier(this._getRecommendationUseCase) 
      : super(const ConversionState());

  Future<void> getExchangeRate({
    required Amount input,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required int type,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final exchangeRate = await _getRecommendationUseCase.execute(
        input: input,
        cryptoCurrencyId: cryptoCurrencyId,
        fiatCurrencyId: fiatCurrencyId,
        type: type,
      );
      
      state = state.copyWith(
        exchangeRate: exchangeRate,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }


  void reset() {
    state = const ConversionState();
  }
}