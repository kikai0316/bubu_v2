import 'dart:ui';

import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/constant/img.dart';
import 'package:flutter/material.dart';

Widget line(
  BuildContext context,
) {
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey.withOpacity(0.3),
  );
}

Widget circleImageWidget({
  required String? image,
  required double size,
  double? radius,
  Widget? child,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    alignment: Alignment.center,
    height: size,
    width: size,
    decoration: BoxDecoration(
      boxShadow: boxShadow,
      image: image == null
          ? notImg()
          : DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
      border: mainBorder(color: Colors.grey.withOpacity(0.3)),
      borderRadius: radius != null ? BorderRadius.circular(radius) : null,
      shape: radius == null ? BoxShape.circle : BoxShape.rectangle,
    ),
    child: child,
  );
}

Widget imgIcon({
  required String file,
  required double size,
  double? pading,
  Color color = blackColor2,
  bool? isGradation,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    alignment: Alignment.center,
    height: size,
    width: size,
    padding: EdgeInsets.all(
      pading ?? 0,
    ),
    decoration: BoxDecoration(
      color: color,
      gradient: isGradation == true ? mainGradation() : null,
      shape: BoxShape.circle,
      boxShadow: boxShadow,
    ),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/$file"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Widget circleWidget({
  required double size,
  required Color color,
  Widget? child,
  BoxBorder? border,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    alignment: Alignment.center,
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: color,
      border: border,
      shape: BoxShape.circle,
    ),
    child: child,
  );
}

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
}) {
  final textWidget = Text(
    text,
    textAlign: textAlign,
    overflow: isOverflow ? TextOverflow.ellipsis : null,
    maxLines: maxLiune,
    style: TextStyle(
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
