// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationDto _$RecommendationDtoFromJson(Map<String, dynamic> json) =>
    RecommendationDto(
      RecommendationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecommendationDtoToJson(RecommendationDto instance) =>
    <String, dynamic>{'data': instance.data};

RecommendationData _$RecommendationDataFromJson(Map<String, dynamic> json) =>
    RecommendationData(
      RecommendationByPrice.fromJson(json['byPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecommendationDataToJson(RecommendationData instance) =>
    <String, dynamic>{'byPrice': instance.byPrice};

RecommendationByPrice _$RecommendationByPriceFromJson(
  Map<String, dynamic> json,
) => RecommendationByPrice(
  RecommendationByPrice._parseDouble(json['fiatToCryptoExchangeRate']),
  json['offerMakerStats'] == null
      ? null
      : OfferMakerStats.fromJson(
          json['offerMakerStats'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RecommendationByPriceToJson(
  RecommendationByPrice instance,
) => <String, dynamic>{
  'fiatToCryptoExchangeRate': instance.fiatToCryptoExchangeRate,
  'offerMakerStats': instance.offerMakerStats,
};

OfferMakerStats _$OfferMakerStatsFromJson(Map<String, dynamic> json) =>
    OfferMakerStats(
      releaseTime: OfferMakerStats._parseDouble(json['releaseTime']),
      payTime: OfferMakerStats._parseDouble(json['payTime']),
      responseTime: OfferMakerStats._parseDouble(json['responseTime']),
      marketMakerOrderTime: OfferMakerStats._parseDouble(
        json['marketMakerOrderTime'],
      ),
    );

Map<String, dynamic> _$OfferMakerStatsToJson(OfferMakerStats instance) =>
    <String, dynamic>{
      'releaseTime': instance.releaseTime,
      'payTime': instance.payTime,
      'responseTime': instance.responseTime,
      'marketMakerOrderTime': instance.marketMakerOrderTime,
    };
