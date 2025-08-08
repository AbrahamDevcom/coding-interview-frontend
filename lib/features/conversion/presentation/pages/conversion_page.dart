import 'package:eldorado_challenge/features/conversion/presentation/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/currency_model.dart';
import '../../../../utils/theme/app_theme.dart';
import '../../domain/entities/amount.dart';
import '../notifier/providers.dart';
import '../widgets/amount_input.dart';
import '../widgets/currency_row.dart';
import '../widgets/result_view.dart';

class ConversionPage extends ConsumerWidget {
  const ConversionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversionState = ref.watch(conversionNotifierProvider);
    final currencyState = ref.watch(currencySelectionProvider);
    final amountState = ref.watch(amountProvider);

    ref.listen(currencySelectionProvider, (previous, current) {
      if (previous != null &&
          (previous.fromCurrency != current.fromCurrency ||
              previous.toCurrency != current.toCurrency)) {
        ref.read(conversionNotifierProvider.notifier).reset();
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(color: AppColors.backgroundLightBlue),
        child: Stack(
          children: [
            Background(),
            Center(
              child: Container(
                margin: const EdgeInsets.all(48),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CurrencyRow(key: Key('currency_row_widget')),

                    const SizedBox(height: 15),

                    const AmountInput(key: Key('amount_input_widget')),

                    const SizedBox(height: 24),

                    ResultView(
                      key: Key('result_view_widget'),
                      exchangeRate: conversionState.exchangeRate,
                      fromCurrency: currencyState.fromCurrency,
                      toCurrency: currencyState.toCurrency,
                      amount: amountState.amount,
                      isLoading: conversionState.isLoading,
                      errorMessage: conversionState.errorMessage,
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      key: const Key('convert_button'),
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () => _handleConversion(context, ref),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Cambiar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleConversion(BuildContext context, WidgetRef ref) async {
    final currencyState = ref.read(currencySelectionProvider);
    final amountState = ref.read(amountProvider);

    if (currencyState.fromCurrency == null ||
        currencyState.toCurrency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona ambas monedas')),
      );
      return;
    }

    if (amountState.amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa una cantidad válida')),
      );
      return;
    }

    final isFromCrypto =
        currencyState.fromCurrency!.type == CurrencyType.crypto;
    final type = isFromCrypto ? 0 : 1;

    try {
      final inputAmount = Amount(
        value: amountState.amount,
        currencyId: currencyState.fromCurrency!.code,
      );

      await ref
          .read(conversionNotifierProvider.notifier)
          .getExchangeRate(
            input: inputAmount,
            cryptoCurrencyId: isFromCrypto
                ? currencyState.fromCurrency!.id
                : currencyState.toCurrency!.id,
            fiatCurrencyId: isFromCrypto
                ? currencyState.toCurrency!.id
                : currencyState.fromCurrency!.id,
            type: type,
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
