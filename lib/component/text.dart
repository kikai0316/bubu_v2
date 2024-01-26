import 'dart:ui';

import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';

Widget nText(
  String text, {
  required double fontSize,
  Color color = Colors.white,
  double bold = 600,
  double height = 1,
  int? maxLiune,
  TextAlign textAlign = TextAlign.center,
  bool? isGradation,
  bool isOverflow = true,
  List<Shadow>? shadows,
}) {
  final textWidget = Text(
    text,
    textAlign: textAlign,
    overflow: isOverflow ? TextOverflow.ellipsis : null,
    maxLines: maxLiune,
    style: TextStyle(
      shadows: shadows,
      height: height,
      decoration: TextDecoration.none,
      fontFamily: "Normal",
      fontVariations: [FontVariation("wght", bold)],
      color: color,
      fontSize: fontSize,
    ),
  );
  return isGradation == true
      ? ShaderMask(
          child: textWidget,
          shaderCallback: (Rect rect) => mainGradation().createShader(rect),
        )
      : textWidget;
}
