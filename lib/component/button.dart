import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/component/text.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAnimatedOpacityButton extends HookConsumerWidget {
  const CustomAnimatedOpacityButton({
    super.key,
    required this.child,
    required this.onTap,
    this.opacity,
  });
  final Widget child;
  final VoidCallback? onTap;
  final double? opacity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTapEvent = useState<bool>(false);
    return GestureDetector(
      onTap: () {
        isTapEvent.value = false;
        onTap?.call();
      },
      onTapDown: (_) => isTapEvent.value = true,
      onTapCancel: () => isTapEvent.value = false,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isTapEvent.value ? opacity ?? 0.6 : 1,
        child: child,
      ),
    );
  }
}

Widget mainButton(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
  double? fontSize,
  Color? backGroundColor,
  Color textColor = Colors.white,
  Color? borderColor,
  double? height,
  double? width,
  double radius = 20,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return CustomAnimatedOpacityButton(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: height ?? safeAreaHeight * 0.075,
      width: width ?? safeAreaWidth,
      decoration: BoxDecoration(
        color: backGroundColor,
        gradient: backGroundColor == null ? mainGradation() : null,
        borderRadius: BorderRadius.circular(radius),
        border: borderColor != null ? Border.all(color: borderColor) : null,
        boxShadow: mainBoxShadow(),
      ),
      child: nText(
        text,
        color: textColor,
        fontSize: fontSize ?? safeAreaWidth / 25,
        shadows: mainBoxShadow(),
      ),
    ),
  );
}

Widget iconButtonWithCancel(
  BuildContext context, {
  required double size,
  required bool isCloseIcon,
  VoidCallback? customOnTap,
  List<Shadow>? shadows,
  bool isBackGroundColor = true,
  double? customIconSize,
}) {
  return CustomAnimatedOpacityButton(
    onTap: customOnTap ?? () => Navigator.pop(context),
    child: circleWidget(
      color: isBackGroundColor ? blackColor2 : Colors.transparent,
      size: size,
      child: Icon(
        size: customIconSize ?? size / 2,
        isCloseIcon ? Icons.close : Icons.arrow_back_ios_new,
        color: Colors.white,
        shadows: shadows,
      ),
    ),
  );
}
