import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/theme/app_theme.dart';
import '../notifier/providers.dart';

class AmountInput extends ConsumerWidget {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyState = ref.watch(currencySelectionProvider);
    final amountNotifier = ref.read(amountProvider.notifier);
    final currencySymbol = currencyState.fromCurrency?.code ?? '\$';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      height: 40,
      child: TextField(
        autofocus: true,
        controller: amountNotifier.controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixText: '$currencySymbol ',
          prefixStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
          hintText: '0.00',
          hintStyle: TextStyle(fontSize: 12, color: AppColors.grey400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        onChanged: (value) {
          ref.read(amountProvider.notifier).updateAmount(value);
          ref.read(conversionNotifierProvider.notifier).reset();
        },
      ),
    );
  }
}
