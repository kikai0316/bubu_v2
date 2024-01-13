import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:flutter/material.dart';

Widget onUser({
  required double size,
  required UserType userData,
  VoidCallback? onTap,
  Widget? child,
}) {
  final userWidget = Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(size / 30),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: mainGradation(),
    ),
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(size / 40),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: blackColor),
      child: circleImageWidget(
        image: userData.profileImg,
        size: double.infinity,
        boxShadow: mainBoxShadow(),
      ),
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
  VoidCallback? onEditUserProfile,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final double mainSize = safeAreaWidth * 0.23;
  final isEditCommentWidget =
      onEditUserProfile != null && userData.comment == null;
  final isCommentWidget = onEditUserProfile != null || userData.comment != null;
  double dotSize(int index) => safeAreaWidth * [0.015, 0.01][index];
  Widget editIcon() {
    if (onEditUserProfile == null) return const SizedBox.shrink();
    return circleWidget(
      size: safeAreaWidth * 0.06,
      color: blackColor2,
      child: CustomAnimatedOpacityButton(
        onTap: onEditUserProfile,
        child: circleWidget(
          size: double.infinity,
          color: Colors.white,
          child: Icon(
            Icons.edit,
            color: Colors.blue,
            size: safeAreaWidth / 25,
            shadows: mainBoxShadow(shadow: 1),
          ),
        ),
      ),
    );
  }

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
              onUser(
                onTap: () {},
                userData: userData,
                size: mainSize - (safeAreaWidth * 0.05),
                child:
                    Align(alignment: Alignment.bottomRight, child: editIcon()),
              ),
              if (isCommentWidget)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(safeAreaWidth * 0.02),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blackColor2,
                      ),
                      child: nText(
                        isEditCommentWidget
                            ? "一言を入力..."
                            : userData.comment ?? "",
                        maxLiune: 3,
                        textAlign: isEditCommentWidget
                            ? TextAlign.center
                            : TextAlign.start,
                        color: isEditCommentWidget ? Colors.grey : Colors.white,
                        fontSize: safeAreaWidth / 50,
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
