import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/component/text.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/utility/screen_transition_utility.dart';
import 'package:bubu_v2/view/home/home_pages/comment_edit_page.dart';
import 'package:flutter/material.dart';

Widget onUser({
  required double size,
  required UserType userData,
  VoidCallback? onTap,
  Widget? child,
}) {
  final userWidget = circleWidget(
    isGradation: true,
    padingSize: size / 30,
    child: imgWidget(
      networkUrl: userData.profileImg,
      assetFile: userData.profileImg == null ? "not.png" : null,
      border: mainBorder(
        color: blackColor,
      ),
      isCircle: true,
    ),
  );
  return SizedBox(
    height: size,
    width: size,
    child: Stack(
      children: [
        if (onTap != null)
          CustomAnimatedOpacityButton(onTap: onTap, child: userWidget)
        else
          userWidget,
        child ?? const SizedBox(),
      ],
    ),
  );
}

Widget onUserWithNear(
  BuildContext context, {
  required UserType userData,
  // required List<UserType> allUserType,
  // required int targetIndex,
  required VoidCallback onTap,
  VoidCallback? onEditUserProfile,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final double mainSize = safeAreaWidth * 0.23;
  final isCommentWidget = onEditUserProfile != null || userData.comment != null;
  return Padding(
    padding: xPadding(
      context,
      top: safeAreaHeight * 0.015,
      xSize: safeAreaWidth * 0.005,
    ),
    child: Column(
      children: [
        SizedBox(
          height: mainSize,
          width: isCommentWidget ? mainSize : mainSize / 1.2,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Hero(
                tag: userData.id,
                child: onUser(
                  onTap: onTap,
                  userData: userData,
                  size: mainSize - (safeAreaWidth * 0.05),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: () {
                      if (onEditUserProfile != null) {
                        return circleWidget(
                          size: safeAreaWidth * 0.06,
                          child: CustomAnimatedOpacityButton(
                            onTap: onEditUserProfile,
                            child: circleWidget(
                              color: Colors.white,
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: safeAreaWidth / 25,
                              ),
                            ),
                          ),
                        );
                      }
                    }(),
                  ),
                ),
              ),
              if (isCommentWidget)
                userCommentWidget(
                  context,
                  userData: userData,
                  isMyUserData: onEditUserProfile != null,
                  onTap: onTap,
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: safeAreaHeight * 0.01),
          child: Container(
            alignment: Alignment.center,
            width: safeAreaWidth * 0.18,
            child: nText(
              onEditUserProfile != null ? "自分" : userData.name,
              fontSize: safeAreaWidth / 45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget userCommentWidget(
  BuildContext context, {
  required UserType userData,
  required bool isMyUserData,
  required VoidCallback onTap,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final isEditDefault = isMyUserData && userData.comment == null;
  double dotSize(int index) => safeAreaWidth * [0.015, 0.01][index];
  return CustomAnimatedOpacityButton(
    onTap: isMyUserData
        ? () => ScreenTransition(
              context,
              CommentEditPage(
                userData: userData,
              ),
            ).top()
        : onTap,
    // ScreenTransition(
    //     context,
    //     FullScreenProfilePage(
    //       allUsers: allUsers,
    //       targetIndex: targetIndex,
    //     )).toTop(),
    opacity: 0.85,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(safeAreaWidth * 0.025),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: blackColor2,
          ),
          child: nText(
            isEditDefault ? "一言を入力..." : userData.comment ?? "",
            maxLiune: 3,
            color: isEditDefault ? Colors.grey : Colors.white,
            fontSize: safeAreaWidth / 45,
          ),
        ),
        for (int i = 0; i < 2; i++)
          Padding(
            padding: EdgeInsets.only(
              top: safeAreaWidth * [0.004, 0][i],
              left: safeAreaWidth * [0.05, 0.065][i],
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
  );
}
