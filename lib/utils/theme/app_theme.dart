import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFFB200);
  static const Color light = Color(0xFFFFB347);

  static const Color backgroundLightBlue = Color(0xFFe0f8fa);
  static const Color backgroundLightYellow = Color(0xFFFFF8E1);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey600 = Color(0xFF7c7c7d);
  static const Color grey400 = Color(0xFF999999);
  static const Color grey200 = Color(0xFFE0E0E0);
  static const Color grey100 = Color(0xFFF5F5F5);

  static const Color error = Color(0xFFE53E3E);
  static const Color errorLight = Color(0xFFFED7D7);
}

class AppGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.backgroundLightBlue, AppColors.backgroundLightYellow],
  );
}
