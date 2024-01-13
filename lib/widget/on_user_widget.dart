import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';

Widget onUser({
  required double size,
}) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(size / 30),
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: mainGradation(),
    ),
    child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(size / 40),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: blackColor),
          child: circleImageWidget(
            image:
                "https://scontent-itm1-1.cdninstagram.com/v/t51.2885-19/326469671_1375751976531027_9070205336824703512_n.jpg?stp=dst-jpg_s320x320&_nc_ht=scontent-itm1-1.cdninstagram.com&_nc_cat=103&_nc_ohc=P0yhYiXeXiAAX-PZwEr&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfB2emSAsG9g01Iy3mOwfD74nwF0w59UrxB9VkA3QZaZaQ&oe=65A69913&_nc_sid=8b3546",
            size: double.infinity,
            boxShadow: mainBoxShadow(),
          ),
        ),
      ],
    ),
  );
}

Widget withOnUserComment(
  BuildContext context, {
  required double size,
  required Widget child,
  required String? message,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  double dotSize(int index) => safeAreaWidth * [0.02, 0.015][index];
  return SizedBox(
    height: size,
    width: message != null ? size : size / 1.2,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        child,
        if (message != null)
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: blackColor2,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(safeAreaWidth * 0.02),
                    child: nText(
                      message,
                      maxLiune: 3,
                      textAlign: TextAlign.start,
                      fontSize: safeAreaWidth / 50,
                    ),
                  ),
                ),
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding: EdgeInsets.only(
                      top: safeAreaWidth * [0.004, 0][i],
                      left: safeAreaWidth * [0.05, 0.07][i],
                    ),
                    child: Container(
                      height: dotSize(i),
                      width: dotSize(i),
                      decoration: const BoxDecoration(
                        color: blackColor2,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}
