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

Widget imgWidget({
  String? assetFile,
  String? networkUrl,
  double? size,
  BoxBorder? border,
  double? radius,
  bool? isCircle,
  Widget? child,
}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      border: border,
      image: assetFile != null
          ? assetImg(assetFile)
          : networkUrl != null
              ? networkImg(networkUrl)
              : null,
      borderRadius:
          isCircle != true ? BorderRadius.circular(radius ?? 10) : null,
      shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
    ),
    child: child,
  );
}

Widget circleWidget({
  required Widget child,
  double? size,
  Color color = blackColor2,
  bool? isGradation,
  List<BoxShadow>? boxShadow,
  double padingSize = 0,
}) {
  return Container(
    alignment: Alignment.center,
    height: size,
    width: size,
    padding: EdgeInsets.all(padingSize),
    decoration: BoxDecoration(
      color: color,
      gradient: isGradation == true ? mainGradation() : null,
      shape: BoxShape.circle,
      boxShadow: boxShadow,
    ),
    child: child,
  );
}

Widget nTextFormField(
  BuildContext context, {
  required TextEditingController? textController,
  required String hintText,
  double? fontSize,
  void Function(String)? onChanged,
  TextAlign textAlign = TextAlign.start,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return TextFormField(
    controller: textController,
    maxLines: null,
    textAlign: textAlign,
    onChanged: onChanged,
    style: TextStyle(
      fontFamily: "Normal",
      fontVariations: const [FontVariation("wght", 700)],
      color: Colors.white,
      fontSize: fontSize ?? safeAreaWidth / 26,
      height: 1.3,
    ),
    decoration: InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: "Normal",
        color: Colors.grey,
        fontVariations: const [FontVariation("wght", 700)],
        fontSize: fontSize ?? safeAreaWidth / 26,
        height: 1.3,
      ),
    ),
  );
}

Widget nContainer({
  double? height,
  double? width,
  Color? color,
  double radius = 0,
  EdgeInsetsGeometry? padding,
  Gradient? gradient,
  AlignmentGeometry? alignment,
  BoxBorder? border,
  Widget? child,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    padding: padding,
    alignment: alignment,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border,
      gradient: gradient,
      boxShadow: boxShadow,
    ),
    child: child,
  );
}
