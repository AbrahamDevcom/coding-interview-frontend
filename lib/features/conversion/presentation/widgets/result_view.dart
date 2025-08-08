import 'package:flutter/material.dart';
import '../../../../core/models/currency_model.dart';
import '../../../../utils/theme/app_theme.dart';
import '../../../../utils/currency_formatter.dart';
import '../../domain/entities/exchange_rate.dart';

class ResultView extends StatelessWidget {
  final ExchangeRate? exchangeRate;
  final CurrencyModel? fromCurrency;
  final CurrencyModel? toCurrency;
  final double amount;
  final bool isLoading;
  final String? errorMessage;

  const ResultView({
    super.key,
    this.exchangeRate,
    this.fromCurrency,
    this.toCurrency,
    required this.amount,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage != null) {
      return _buildErrorState(errorMessage!);
    }

    if (exchangeRate != null && fromCurrency != null && toCurrency != null) {
      return _buildResultsState(
        exchangeRate!,
        fromCurrency!,
        toCurrency!,
        amount,
      );
    }

    return _buildPlaceholderState();
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          _buildResultRow('Tasa estimada', _buildSkeleton()),
          const SizedBox(height: 8),
          _buildResultRow('Recibirás', _buildSkeleton()),
          const SizedBox(height: 8),
          _buildResultRow('Tiempo estimado', _buildSkeleton()),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Column(
      children: [
        const Icon(Icons.error_outline, color: AppColors.error, size: 32),
        const SizedBox(height: 8),
        Text(
          'Error: $error',
          style: const TextStyle(color: AppColors.error),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPlaceholderState() {
    return Column(
      children: [
        _buildResultRow('Tasa estimada', '- -'),
        const SizedBox(height: 8),
        _buildResultRow('Recibirás', '- -'),
        const SizedBox(height: 8),
        _buildResultRow('Tiempo estimado', '- -'),
      ],
    );
  }

  Widget _buildResultsState(
    ExchangeRate exchangeRate,
    CurrencyModel fromCurrency,
    CurrencyModel toCurrency,
    double amount,
  ) {
    final rate = exchangeRate.rate;

    double receivedAmount;
    String rateDisplay;

    if (fromCurrency.type == CurrencyType.crypto) {
      receivedAmount = amount * rate;
      rateDisplay = CurrencyFormatter.formatRate(
        rate,
        fromCurrency.code,
        toCurrency.code,
      );
    } else {
      receivedAmount = amount / rate;
      final inverseRate = 1 / rate;
      rateDisplay = CurrencyFormatter.formatRate(
        inverseRate,
        fromCurrency.code,
        toCurrency.code,
      );
    }

    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          _buildResultRow('Tasa estimada', '≈ $rateDisplay'),
          const SizedBox(height: 8),
          _buildResultRow(
            'Recibirás',
            '≈ ${CurrencyFormatter.formatAmount(receivedAmount, toCurrency.code)}',
          ),
          const SizedBox(height: 8),
          _buildResultRow(
            'Tiempo estimado',
            _formatEstimatedTime(exchangeRate.estimatedTimeMinutes),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.grey600,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        value is Widget
            ? value
            : Text(
                value.toString(),
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ],
    );
  }

  Widget _buildSkeleton() {
    return Container(
      width: 80,
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  String _formatEstimatedTime(double? minutes) {
    if (minutes == null || minutes <= 0) {
      return '≈ 10 Min';
    }

    if (minutes < 1) {
      return '< 1 Min';
    } else if (minutes < 60) {
      return '≈ ${minutes.round()} Min';
    } else {
      final hours = (minutes / 60).floor();
      final remainingMinutes = (minutes % 60).round();
      if (remainingMinutes == 0) {
        return '≈ ${hours}h';
      } else {
        return '≈ ${hours}h ${remainingMinutes}min';
      }
    }
  }
}
