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
  BoxBorder? border,
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

Widget imgIcon({required String file, required double size, double? pading}) {
  return Container(
    alignment: Alignment.center,
    height: size,
    width: size,
    padding: EdgeInsets.all(
      pading ?? 0,
    ),
    decoration: BoxDecoration(
      color: pading != null ? blackColor2 : null,
      shape: BoxShape.circle,
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

Widget nText(
  String text, {
  required double fontSize,
  Color color = Colors.white,
  double bold = 700,
  double height = 1,
  int? maxLiune,
  TextAlign textAlign = TextAlign.center,
  bool? isGradation,
}) {
  final textWidget = Text(
    text,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLiune,
    style: TextStyle(
      height: height,
      decoration: TextDecoration.none,
      fontFamily: "Normal",
      fontVariations: [FontVariation("wght", bold)],
      color: color,
      shadows: mainBoxShadow(),
      fontSize: fontSize,
    ),
  );
  return isGradation == true
      ? ShaderMask(
          child: textWidget,
          shaderCallback: (Rect rect) {
            return mainGradation().createShader(rect);
          },
        )
      : textWidget;
}
