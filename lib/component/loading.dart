import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget loadinPage(
  BuildContext context, {
  bool isLoading = true,
  String? text,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return Visibility(
    visible: isLoading,
    child: Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.7),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            color: Colors.white,
            radius: safeAreaHeight * 0.018,
          ),
          if (text != null) ...{
            Padding(
              padding: EdgeInsets.only(top: safeAreaHeight * 0.01),
              child: nText(
                text,
                fontSize: safeAreaWidth / 30,
              ),
            ),
          },
        ],
      ),
    ),
  );
}

Widget upLoadPage(
  BuildContext context, {
  required int? percentage,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final setPercentage = percentage ?? 0;
  return Visibility(
    visible: percentage != null,
    child: Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.9),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            animation: true,
            radius: safeAreaWidth * 0.2,
            lineWidth: 7.0,
            percent: setPercentage / 100,
            progressColor: greenColor,
            backgroundColor: Colors.grey,
            center: percentage != 100
                ? nText(
                    "$setPercentage%",
                    fontSize: safeAreaWidth / 18,
                  )
                : Icon(
                    Icons.done,
                    color: greenColor,
                    size: safeAreaWidth / 5,
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(top: safeAreaHeight * 0.03),
            child: nText(
              setPercentage != 100 ? "アップロード中" : "アップロード完了!",
              fontSize: safeAreaWidth / 25,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget loadingPageWithLogo(
  BuildContext context,
) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return Container(
    alignment: Alignment.center,
    color: Colors.black,
    height: double.infinity,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        nText(
          " BUBU.",
          fontSize: safeAreaWidth / 8,
          bold: 900,
          isGradation: true,
        ),
        Padding(
          padding: EdgeInsets.only(top: safeAreaHeight * 0.02),
          child: CupertinoActivityIndicator(
            color: Colors.white,
            radius: safeAreaHeight * 0.018,
          ),
        ),
      ],
    ),
  );
}
