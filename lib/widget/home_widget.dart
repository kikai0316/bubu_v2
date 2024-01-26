import 'dart:ui';

import 'package:bubu_v2/bespoke_profile_swiper/profile_swiper_page.dart';
import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/utility/screen_transition_utility.dart';
import 'package:bubu_v2/utility/utility.dart';
import 'package:bubu_v2/widget/on_user_widget.dart';
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
      boxShadow: mainBoxShadow(),
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
            child: imgWidget(
              assetFile: "setting.png",
            ),
          ),
        ),
      ],
    ),
  );
}

Widget homeButtomButtonWidget(
  BuildContext context, {
  required VoidCallback onTap,
  required bool isStart,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: xPadding(context),
    child: Container(
      alignment: Alignment.topCenter,
      height: isStart ? safeAreaHeight * 0.13 : safeAreaHeight * 0.16,
      decoration: BoxDecoration(
        color: blackColor2,
        borderRadius: BorderRadius.circular(35),
        boxShadow: mainBoxShadow(),
      ),
      child: Stack(
        children: [
          Padding(
            padding: xPadding(
              context,
              xSize: safeAreaWidth * 0.04,
              bottom: safeAreaWidth * 0.04,
              top: (safeAreaWidth * 0.04) +
                  (!isStart ? safeAreaHeight * 0.03 : 0),
            ),
            child: mainButton(
              context,
              text: isStart ? "周囲のデバイスとの通信を開始" : "停止",
              onTap: onTap,
            ),
          ),
          if (!isStart)
            Align(
              alignment: const Alignment(0, -1.9),
              child: circleWidget(
                size: safeAreaWidth * 0.15,
                boxShadow: mainBoxShadow(color: pinkColor.withOpacity(0.3)),
                isGradation: true,
                padingSize: safeAreaWidth * 0.03,
                child: imgWidget(
                  assetFile: "radar.gif",
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget nearWidget(
  BuildContext context, {
  required List<UserType> nearUsers,
  required UserType userProfile,
  required VoidCallback onEditProfileImg,
  required VoidCallback onEditUserProfile,
  required VoidCallback onEditComment,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final padingWidget = SizedBox(
    width: safeAreaWidth * 0.01,
  );
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        padingWidget,
        for (int i = 0; i < nearUsers.length + 1; i++)
          onUserWithNear(
            context,
            onEditUserProfile: i == 0
                ? () => showBottomMenu(
                      context,
                      itemList: List.generate(
                        3,
                        (i) => BottomMenuItemType(
                          text: [
                            "プロフィール画像を変更",
                            "一言を編集",
                            "基本情報を編集",
                          ][i],
                          onTap: [
                            onEditProfileImg,
                            onEditComment,
                            onEditUserProfile,
                          ][i],
                        ),
                      ),
                    )
                : null,
            onTap: () => ScreenTransition(
              context,
              ProfileSwiperPage(
                allUsers: i == 0 ? [userProfile] : nearUsers,
                targetIndex: i == 0 ? 0 : i - 1,
              ),
            ).hero(),
            userData: i == 0 ? userProfile : nearUsers[i - 1],
          ),
        padingWidget,
      ],
    ),
  );
}
