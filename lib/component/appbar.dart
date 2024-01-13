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
          CustomAnimatedOpacityButton(
            onTap: () {},
            child: circleImageWidget(
              image:
                  "https://scontent-itm1-1.cdninstagram.com/v/t51.2885-19/326469671_1375751976531027_9070205336824703512_n.jpg?stp=dst-jpg_s320x320&_nc_ht=scontent-itm1-1.cdninstagram.com&_nc_cat=103&_nc_ohc=P0yhYiXeXiAAX-PZwEr&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfB2emSAsG9g01Iy3mOwfD74nwF0w59UrxB9VkA3QZaZaQ&oe=65A69913&_nc_sid=8b3546",
              size: safeAreaWidth / 9,
            ),
          ),
        ],
      ),
    ),
  );
}
