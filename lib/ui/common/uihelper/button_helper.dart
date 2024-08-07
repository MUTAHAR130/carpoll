// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

class button_helper extends StatelessWidget {
  button_helper(
      {super.key,
      required this.onpress,
      required this.color,
      this.padding = const EdgeInsetsDirectional.all(8),
      this.margin = const EdgeInsetsDirectional.all(8),
      required this.width,
      required this.child,
      this.raduis = 5,
      this.boxshadow = const [],
      this.border = const Border()});
  Function onpress;
  final Color color;
  EdgeInsetsDirectional padding, margin;
  double width;
  Widget child;
  double raduis;
  Border border;
  List<BoxShadow> boxshadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onpress(),
      child: Container(
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(raduis),
            boxShadow: boxshadow,
            border: border),
        child: child,
      ),
    );
  }
}
