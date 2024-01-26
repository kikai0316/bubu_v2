import 'package:bubu_v2/component/text.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(
  BuildContext context, {
  VoidCallback? onTap,
  String? title,
  required String subTitle,
  String? buttonRightText,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: nText(
        title ?? "エラー",
        color: Colors.black,
        fontSize: safeAreaWidth / 25,
      ),
      content: Padding(
        padding: EdgeInsets.only(top: safeAreaHeight * 0.01),
        child: nText(
          subTitle,
          fontSize: safeAreaWidth / 35,
          bold: 500,
          height: 1.2,
          color: Colors.black.withOpacity(0.7),
          isOverflow: false,
        ),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: nText(
            buttonRightText != null ? "キャンセル" : "OK",
            color: Colors.blue,
            fontSize: safeAreaWidth / 27,
          ),
        ),
        if (buttonRightText != null)
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onTap,
            child: nText(
              buttonRightText,
              color: Colors.red,
              fontSize: safeAreaWidth / 28,
            ),
          ),
      ],
    ),
  );
}
