import 'package:flutter/material.dart';

import '../../../../core/models/currency_model.dart';
import '../../../../utils/theme/app_theme.dart';

class CurrencyTile extends StatelessWidget {
  final String label;
  final CurrencyModel? currency;
  final VoidCallback onTap;

  const CurrencyTile({
    super.key,
    required this.label,
    this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currency != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    currency!.flagAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        currency!.type == CurrencyType.fiat
                            ? Icons.flag
                            : Icons.currency_bitcoin,
                        size: 16,
                        color: AppColors.grey400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  currency!.code,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.grey400,
                  size: 20,
                ),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: AppColors.grey400,
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  'Selecciona',
                  style: TextStyle(color: AppColors.grey600, fontSize: 14),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
