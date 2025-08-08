import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api/recommendations_api.dart';
import '../../data/repo/conversion_repository_impl.dart';
import '../../domain/usecases/get_recommendation_usecase.dart';
import 'conversion_notifier.dart';
import 'currency_selection_notifier.dart';
import 'amount_notifier.dart';

final recommendationsApiProvider = Provider((_) => RecommendationsApi());

final conversionRepoProvider = Provider(
  (ref) => ConversionRepositoryImpl(ref.read(recommendationsApiProvider)),
);

final getRecommendationUseCaseProvider = Provider(
  (ref) => GetRecommendationUseCase(ref.read(conversionRepoProvider)),
);

final conversionNotifierProvider = 
    StateNotifierProvider<ConversionNotifier, ConversionState>(
  (ref) => ConversionNotifier(ref.read(getRecommendationUseCaseProvider)),
);

final currencySelectionProvider = 
    StateNotifierProvider<CurrencySelectionNotifier, CurrencySelectionState>(
  (ref) => CurrencySelectionNotifier(),
);

final amountProvider = 
    StateNotifierProvider<AmountNotifier, AmountState>(
  (ref) => AmountNotifier(),
);
