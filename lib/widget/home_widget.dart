import 'dart:ui';

import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';

Widget nearbyWarningWidget(
  BuildContext context,
) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  InlineSpan textWidget(
    String text,
  ) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: "Normal",
        fontVariations: const [FontVariation("wght", 700)],
        color: text == "ON" ? greenColor : Colors.white,
        fontSize: safeAreaWidth / 30,
      ),
    );
  }

  return Container(
    height: safeAreaHeight * 0.2,
    width: safeAreaWidth,
    decoration: BoxDecoration(
      color: blackColor2,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              textWidget("端末の設定からローカルネットワークを\n「 "),
              textWidget("ON"),
              textWidget(" 」にしてください。"),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: safeAreaHeight * 0.015),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(safeAreaWidth * 0.015),
            height: safeAreaHeight * 0.05,
            width: safeAreaWidth * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: mainBoxShadow(),
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/setting.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
