import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/amount_sanitizer.dart';

class AmountState {
  final double amount;
  final String amountText;

  const AmountState({this.amount = 0.0, this.amountText = ''});

  AmountState copyWith({double? amount, String? amountText}) {
    return AmountState(
      amount: amount ?? this.amount,
      amountText: amountText ?? this.amountText,
    );
  }
}

class AmountNotifier extends StateNotifier<AmountState> {
  AmountNotifier() : super(const AmountState());

  final TextEditingController controller = TextEditingController();

  void updateAmount(String value) {
    final doubleValue = AmountSanitizer.sanitizeAmount(value);
    state = state.copyWith(amount: doubleValue, amountText: value);
    controller.text = value;
  }

  void clearAmount() {
    state = const AmountState();
    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
