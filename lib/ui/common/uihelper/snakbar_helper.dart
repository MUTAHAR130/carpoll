// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../app_colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show_snackbar(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget displaysimpleprogress(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(
      strokeWidth: 6.0,
      valueColor: AlwaysStoppedAnimation<Color>(kcPrimaryColor),
    ),
  );
}

void displayprogress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 6.0,
            valueColor: AlwaysStoppedAnimation<Color>(kcPrimaryColor),
          ),
        ),
      );
    },
  );
}

void hideprogress(BuildContext context) {
  Navigator.pop(context);
}
