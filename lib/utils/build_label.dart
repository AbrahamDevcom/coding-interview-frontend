import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

Widget buildLabel(BuildContext context, String text) {
  return Container(
    color: AppColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 8,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
