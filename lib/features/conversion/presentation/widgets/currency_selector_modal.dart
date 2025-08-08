
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/currency_model.dart';
import '../notifier/providers.dart';

class CurrencySelectorModal extends ConsumerWidget {
  final CurrencyType currencyType;
  final bool isSelectingFrom;
  
  const CurrencySelectorModal({
    required this.currencyType,
    required this.isSelectingFrom,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyState = ref.watch(currencySelectionProvider);
    final availableCurrencies = CurrencyData.getCurrenciesByType(currencyType);
    final selectedCurrency = isSelectingFrom 
        ? currencyState.fromCurrency 
        : currencyState.toCurrency;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                currencyType == CurrencyType.fiat ? 'FIAT' : 'CRYPTO',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: availableCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = availableCurrencies[index];
                  final isSelected = selectedCurrency?.code == currency.code;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            currency.flagAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                                Icon(
                                  currencyType == CurrencyType.fiat 
                                      ? Icons.flag 
                                      : Icons.currency_bitcoin,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                          ),
                        ),
                      ),
                      title: Text(
                        currency.code,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        currency.fullName,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      trailing: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.orange : Colors.grey[300]!,
                            width: 2,
                          ),
                          color: isSelected ? Colors.orange : Colors.transparent,
                        ),
                        child: isSelected 
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                      onTap: () {
                        if (isSelectingFrom) {
                          ref.read(currencySelectionProvider.notifier)
                              .selectFromCurrency(currency);
                        } else {
                          ref.read(currencySelectionProvider.notifier)
                              .selectToCurrency(currency);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
