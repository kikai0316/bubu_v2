import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/widget/on_user_widget.dart';
import 'package:flutter/material.dart';

Widget onMessage(BuildContext context, {required UserType userData}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: xPadding(
      context,
      bottom: safeAreaHeight * 0.015,
    ),
    child: GestureDetector(
      child: Container(
        padding: xPadding(
          context,
        ),
        height: safeAreaHeight * 0.11,
        decoration: BoxDecoration(
          color: blackColor2,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: safeAreaWidth * 0.03),
              child: onUser(size: safeAreaHeight * 0.07, userData: userData),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    2,
                    (i) => Padding(
                      padding: EdgeInsets.only(
                        bottom: i == 0 ? safeAreaHeight * 0.007 : 0,
                      ),
                      child: nText(
                        "だいすけだお",
                        color: [Colors.white, Colors.grey][i],
                        fontSize: safeAreaWidth / 35,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: xPadding(context, xSize: safeAreaWidth * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  nText(
                    "たったいま",
                    color: Colors.grey,
                    fontSize: safeAreaWidth / 45,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: safeAreaHeight * 0.015),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Visibility(
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        visible: false,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: mainGradation(),
                            shape: BoxShape.circle,
                          ),
                          child: Badge.count(
                            backgroundColor: Colors.transparent,
                            count: 3,
                            textStyle: TextStyle(
                              fontSize: safeAreaWidth / 40,
                              shadows: mainBoxShadow(
                                shadow: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
