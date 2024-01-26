import 'package:bubu_v2/constant/color.dart';
import 'package:flutter/material.dart';

double safeHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

Gradient mainGradation() {
  return const LinearGradient(
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft,
    colors: [yellowColor, pinkColor, blueColor],
  );
}

BoxBorder mainBorder({Color? color, double width = 1}) {
  return Border.all(
    color: color ?? Colors.grey.withOpacity(0.3),
    width: width,
  );
}

List<BoxShadow> mainBoxShadow({double shadow = 0.5, Color? color}) {
  return [
    BoxShadow(
      color: color ?? Colors.black.withOpacity(shadow),
      blurRadius: 20,
      spreadRadius: 1.0,
    ),
  ];
}

EdgeInsetsGeometry xPadding(
  BuildContext context, {
  double? xSize,
  double top = 0,
  double bottom = 0,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return EdgeInsets.only(
    left: xSize ?? safeAreaWidth * 0.03,
    right: xSize ?? safeAreaWidth * 0.03,
    top: top,
    bottom: bottom,
  );
}

EdgeInsetsGeometry yPadding(
  BuildContext context, {
  double? ySize,
  double left = 0,
  double right = 0,
}) {
  final safeAreaHeight = safeHeight(context);
  return EdgeInsets.only(
    left: left,
    right: right,
    top: ySize ?? safeAreaHeight * 0.02,
    bottom: ySize ?? safeAreaHeight * 0.02,
  );
}

EdgeInsetsGeometry customPadding({
  double top = 0,
  double bottom = 0,
  double left = 0,
  double right = 0,
}) {
  return EdgeInsets.only(
    left: left,
    right: right,
    top: top,
    bottom: bottom,
  );
}
