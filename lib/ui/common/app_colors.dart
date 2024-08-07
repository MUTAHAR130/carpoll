import 'package:flutter/material.dart';

const Color kcPrimaryColor = Colors.yellow;
const Color kcPrimaryColorDark = Colors.amber;
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color white = Colors.white;
const Color red = Colors.red;

Color getColorWithOpacity(Color colors, double val) {
  return colors.withOpacity(val);
}
