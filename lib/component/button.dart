import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAnimatedOpacityButton extends HookConsumerWidget {
  const CustomAnimatedOpacityButton({
    super.key,
    required this.child,
    required this.onTap,
  });
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTapEvent = useState<bool>(false);
    return GestureDetector(
      onTap: () {
        isTapEvent.value = false;
        onTap();
      },
      onTapDown: (_) => isTapEvent.value = true,
      onTapCancel: () => isTapEvent.value = false,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isTapEvent.value ? 0.6 : 1,
        child: child,
      ),
    );
  }
}

Widget mainButton(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
  Color? backGroundColor,
  Color textColor = Colors.white,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return CustomAnimatedOpacityButton(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: safeAreaHeight * 0.075,
      width: safeAreaWidth,
      decoration: BoxDecoration(
        color: backGroundColor,
        gradient: backGroundColor == null ? mainGradation() : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: mainBoxShadow(),
      ),
      child: nText(
        text,
        color: textColor,
        fontSize: safeAreaWidth / 27,
      ),
    ),
  );
}
