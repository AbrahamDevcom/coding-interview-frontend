class AmountSanitizer {
  static double sanitizeAmount(String value) {
    String sanitizedValue = value;
    
    if (RegExp(r'\.\d{3}$').hasMatch(sanitizedValue)) {
      sanitizedValue = sanitizedValue.replaceAll('.', '');
    }
    
    return double.tryParse(sanitizedValue) ?? 0.0;
  }
}