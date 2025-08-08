import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'client.dart';

part 'recommendations_api.g.dart';

@RestApi()
abstract class RecommendationsApi {
  factory RecommendationsApi([Dio? dio]) {
    return _RecommendationsApi(dio ?? ApiClient.instance);
  }

  @GET('/orderbook/public/recommendations')
  Future<dynamic> getRecommendations({
    @Query('type') required int type,
    @Query('cryptoCurrencyId') required String cryptoCurrencyId,
    @Query('fiatCurrencyId') required String fiatCurrencyId,
    @Query('amount') required double amount,
    @Query('amountCurrencyId') required String amountCurrencyId,
  });
}