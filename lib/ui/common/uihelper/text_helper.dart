// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_strings.dart';
import '../ui_helpers.dart';

class text_helper extends StatelessWidget {
  text_helper(
      {super.key,
      required this.data,
      required this.font,
      required this.color,
      required this.size,
      this.bold = false,
      this.textDecoration,
      this.textAlign = TextAlign.center});

  String data, font;
  Color color;
  double? size;
  bool bold;
  TextAlign textAlign;

  TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: customstyle(font, color, size, context, bold, textDecoration),
      textAlign: textAlign,
    );
  }

  static TextStyle customstyle(String font, Color color, double? size,
      BuildContext context, bool bold, TextDecoration? textDecoration) {
    if (font == poppins) {
      return GoogleFonts.poppins(
          color: color,
          decoration: textDecoration,
          fontSize: getResponsiveFontSize(context, fontSize: size) * 3,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    } else if (font == roboto) {
      return GoogleFonts.roboto(
          color: color,
          decoration: textDecoration,
          fontSize: getResponsiveFontSize(context, fontSize: size) * 3,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    } else {
      return GoogleFonts.montserrat(
          color: color,
          decoration: textDecoration,
          fontSize: getResponsiveFontSize(context, fontSize: size) * 3,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    }
  }
}
