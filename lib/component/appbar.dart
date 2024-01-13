import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget homeAppBar(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: SizedBox(
      width: safeAreaWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAnimatedOpacityButton(
            onTap: () {},
            child: imgIcon(
              file: "menu_icon.png",
              size: safeAreaWidth / 8,
              pading: safeAreaWidth * 0.035,
            ),
          ),
          nText(
            " BUBU.",
            fontSize: safeAreaWidth / 13,
            bold: 900,
            isGradation: true,
          ),
          SizedBox(
            width: safeAreaWidth / 8,
          ),
        ],
      ),
    ),
  );
}
