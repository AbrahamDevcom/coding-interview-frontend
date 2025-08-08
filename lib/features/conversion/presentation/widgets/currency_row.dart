import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/currency_model.dart';
import '../../../../utils/theme/app_theme.dart';
import '../../../../utils/build_label.dart';
import '../notifier/providers.dart';
import 'currency_selector_modal.dart';
import 'currency_switch.dart';
import 'currency_tile.dart';

class CurrencyRow extends ConsumerWidget {
  const CurrencyRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyState = ref.watch(currencySelectionProvider);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CurrencyTile(
                label: 'TENGO',
                currency: currencyState.fromCurrency,
                onTap: () => _showCurrencySelector(
                  context,
                  ref,
                  currencyState.fromCurrency?.type ?? CurrencyType.crypto,
                  true,
                ),
              ),
              const SizedBox(width: 32),
              CurrencyTile(
                label: 'QUIERO',
                currency: currencyState.toCurrency,
                onTap: () => _showCurrencySelector(
                  context,
                  ref,
                  currencyState.toCurrency?.type ?? CurrencyType.fiat,
                  false,
                ),
              ),
            ],
          ),
        ),
        QuoteCurrencySwitch(),

        Positioned(top: -5, left: 25, child: buildLabel(context, 'TENGO')),
        Positioned(top: -5, right: 25, child: buildLabel(context, 'QUIERO')),
      ],
    );
  }

  void _showCurrencySelector(
    BuildContext context,
    WidgetRef ref,
    CurrencyType currencyType,
    bool isSelectingFrom,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CurrencySelectorModal(
        currencyType: currencyType,
        isSelectingFrom: isSelectingFrom,
      ),
    );
  }
}
