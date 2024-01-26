import 'dart:ui';

import 'package:bubu_v2/component/appbar.dart';
import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessagePage extends HookConsumerWidget {
  const MessagePage({
    super.key,
    required this.userData,
  });
  final UserType userData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          padding: customPadding(top: safeAreaHeight * 0.05),
          height: double.infinity,
          width: double.infinity,
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.1),
            appBar: nAppBar(
              context,
              customHeight: safeAreaHeight * 1,
              customLeftIcon: iconButtonWithCancel(
                context,
                size: safeAreaWidth / 15,
                customIconSize: safeAreaWidth / 15,
                isBackGroundColor: false,
                isCloseIcon: false,
              ),
              customTitle: Column(
                children: [
                  imgWidget(
                    size: safeAreaWidth * 0.15,
                    isCircle: true,
                    border: mainBorder(width: 0.5),
                    networkUrl: userData.profileImg,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
