import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/component/text.dart';
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
            child: Padding(
              padding: EdgeInsets.all(safeAreaWidth / 27),
              child: imgWidget(
                assetFile: "menu_icon.png",
              ),
            ),
          ),
          nText(
            " BUBU.",
            fontSize: safeAreaWidth / 13,
            bold: 900,
            isGradation: true,
          ),
          SizedBox(
            width: safeAreaWidth / 8,
          ),
        ],
      ),
    ),
  );
}

PreferredSizeWidget? nAppBar(
  BuildContext context, {
  double? customHeight,
  String? title,
  Widget? customLeftIcon,
  Widget? customRightIcon,
  Widget? customTitle,
  Color backgroundColor = Colors.transparent,
  bool isCloseIcon = false,
  bool isLeftIcon = true,
  VoidCallback? customLeftOnTap,
  double? leftCustomIconSize,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final appbarWidget = AppBar(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: SizedBox(
      width: safeAreaWidth,
      child: Row(
        children: [
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            visible: isLeftIcon,
            child: customLeftIcon ??
                iconButtonWithCancel(
                  context,
                  size: safeAreaWidth * 0.11,
                  isCloseIcon: isCloseIcon,
                  customIconSize: leftCustomIconSize,
                  customOnTap: customLeftOnTap,
                ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: customTitle ??
                  nText(
                    title ?? "",
                    fontSize: safeAreaWidth / 23,
                    bold: 700,
                  ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: safeAreaWidth * 0.11,
            child: customRightIcon,
          ),
        ],
      ),
    ),
  );
  if (customHeight != null) {
    return PreferredSize(
      preferredSize: Size.fromHeight(customHeight),
      child: appbarWidget,
    );
  }
  return appbarWidget;
}
