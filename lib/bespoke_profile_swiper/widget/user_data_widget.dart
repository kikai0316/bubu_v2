import 'package:bubu_v2/component/text.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:flutter/material.dart';

Widget userNameAndCommentWidget(BuildContext context, UserType userData) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: xPadding(context),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nText(
          userData.name,
          fontSize: safeAreaWidth / 20,
          isOverflow: false,
          shadows: mainBoxShadow(),
        ),
        Padding(
          padding: yPadding(context),
          child: nText(
            userData.comment ?? "",
            fontSize: safeAreaWidth / 25,
            isOverflow: false,
            bold: 400,
            shadows: mainBoxShadow(),
          ),
        ),
      ],
    ),
  );
}
