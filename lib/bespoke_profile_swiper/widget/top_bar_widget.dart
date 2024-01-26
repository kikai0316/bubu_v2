import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TopBar extends HookWidget {
  const TopBar({
    super.key,
    required this.animationController,
  });
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: xPadding(
        context,
        top: safeAreaHeight * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          nContainer(
            radius: 50,
            boxShadow: mainBoxShadow(color: Colors.black.withOpacity(0.5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, _) {
                  return SizedBox(
                    height: safeAreaHeight * 0.0025,
                    child: LinearProgressIndicator(
                      value: animationController.value,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: customPadding(top: safeAreaHeight * 0.01),
            child: iconButtonWithCancel(
              context,
              size: safeAreaWidth / 12,
              customIconSize: safeAreaWidth / 12,
              isCloseIcon: true,
              isBackGroundColor: false,
            ),
          ),
        ],
      ),
    );
  }
}
