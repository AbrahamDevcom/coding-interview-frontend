import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/exchange_rate.dart';

part 'recommendation_dto.g.dart';

@JsonSerializable()
class RecommendationDto {
  @JsonKey(name: 'data')
  final RecommendationData data;

  RecommendationDto(this.data);

  factory RecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendationDtoFromJson(json);

  ExchangeRate toEntity({
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
  }) {
    final rate = data.byPrice.fiatToCryptoExchangeRate;
    
    double? estimatedTime;
    final stats = data.byPrice.offerMakerStats;
    if (stats != null) {
      estimatedTime = stats.marketMakerOrderTime > 0 
        ? stats.marketMakerOrderTime 
        : (stats.payTime + stats.releaseTime);
    }
    
    return ExchangeRate(
      rate: rate,
      baseCurrencyId: cryptoCurrencyId,
      quoteCurrencyId: fiatCurrencyId,
      estimatedTimeMinutes: estimatedTime,
    );
  }
}

@JsonSerializable()
class RecommendationData {
  final RecommendationByPrice byPrice;
  RecommendationData(this.byPrice);

  factory RecommendationData.fromJson(Map<String, dynamic> json) => 
      _$RecommendationDataFromJson(json);
}

@JsonSerializable()
class RecommendationByPrice {
  @JsonKey(name: 'fiatToCryptoExchangeRate', fromJson: _parseDouble)
  final double fiatToCryptoExchangeRate;
  
  final OfferMakerStats? offerMakerStats;
  
  RecommendationByPrice(this.fiatToCryptoExchangeRate, this.offerMakerStats);

  factory RecommendationByPrice.fromJson(Map<String, dynamic> json) =>
      _$RecommendationByPriceFromJson(json);
      
  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.parse(value);
    throw FormatException('Cannot parse $value to double');
  }
}

@JsonSerializable()
class OfferMakerStats {
  @JsonKey(fromJson: OfferMakerStats._parseDouble)
  final double releaseTime;
  
  @JsonKey(fromJson: OfferMakerStats._parseDouble) 
  final double payTime;
  
  @JsonKey(fromJson: OfferMakerStats._parseDouble)
  final double responseTime;
  
  @JsonKey(fromJson: OfferMakerStats._parseDouble)
  final double marketMakerOrderTime;

  OfferMakerStats({
    required this.releaseTime,
    required this.payTime, 
    required this.responseTime,
    required this.marketMakerOrderTime,
  });

  factory OfferMakerStats.fromJson(Map<String, dynamic> json) =>
      _$OfferMakerStatsFromJson(json);
      
  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.parse(value);
    return 0.0;
  }
}
