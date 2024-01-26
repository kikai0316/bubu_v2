import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/utility/utility.dart';
import 'package:bubu_v2/view/message/message_sheet.dart';
import 'package:flutter/material.dart';

Widget bottomWidget(
  BuildContext context,
) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: xPadding(context, top: safeAreaHeight * 0.025),
    child: mainButton(
      context,
      text: "メッセージを送信...",
      onTap: () => bottomSheet(
        context,
        page: MessageBottomSheet(
          onTap: (value) {},
        ),
      ),
      height: safeAreaHeight * 0.06,
      radius: 50,
      fontSize: safeAreaWidth / 30,
      textColor: Colors.white.withOpacity(0.7),
      backGroundColor: Colors.transparent,
      borderColor: Colors.white.withOpacity(0.7),
    ),
  );
}
