import 'package:bubu_v2/component/appbar.dart';
import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/widget/home_widget.dart';
import 'package:bubu_v2/widget/on_message_widget.dart';
import 'package:bubu_v2/widget/on_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final isStart = useState<bool>(false);

    return Scaffold(
      backgroundColor: blackColor,
      appBar: homeAppBar(context),
      body: isStart.value
          ? Stack(
              children: [
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: isStart.value ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: xPadding(context, top: safeAreaHeight * 0.03),
                        child: nText(
                          "付近のユーザー",
                          fontSize: safeAreaWidth / 25,
                          isGradation: true,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: safeAreaWidth * 0.01,
                            ),
                            ...List.generate(
                              4,
                              (i) => Padding(
                                padding: xPadding(
                                  context,
                                  top: safeAreaHeight * 0.015,
                                  xSize: safeAreaWidth * 0.005,
                                ),
                                child: withOnUserComment(
                                  context,
                                  size: safeAreaWidth * 0.23,
                                  message: i == 0 ? "あああああああああああああああああ" : null,
                                  child: onUser(
                                    size: safeAreaWidth * 0.18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: safeAreaWidth * 0.01,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: xPadding(context, top: safeAreaHeight * 0.015),
                        child: line(context),
                      ),
                      Padding(
                        padding: xPadding(
                          context,
                          top: safeAreaHeight * 0.02,
                          bottom: safeAreaHeight * 0.02,
                        ),
                        child: nText(
                          "トーク",
                          fontSize: safeAreaWidth / 20,
                          isGradation: true,
                        ),
                      ),
                      ...List.generate(4, (index) => onMessage(context)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: xPadding(context),
                    child: Container(
                      padding: EdgeInsets.all(safeAreaWidth * 0.04),
                      alignment: Alignment.topCenter,
                      height: safeAreaHeight * 0.13,
                      decoration: BoxDecoration(
                        color: blackColor2,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: mainButton(
                        context,
                        text: "停止",
                        backGroundColor: Colors.red,
                        onTap: () => isStart.value = false,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : _startWidget(context, isStart),
    );
  }

  Widget _startWidget(BuildContext context, ValueNotifier<bool> isStart) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final safeAreaHeight = safeHeight(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imgIcon(file: "background2.png", size: safeAreaWidth * 0.35),
              nText(
                "半径20m以内の\nユーザーと繋がるアプリ",
                height: 0,
                fontSize: safeAreaWidth / 15,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(safeAreaWidth * 0.03),
          child: nearbyWarningWidget(context),
        ),
        Padding(
          padding: xPadding(context),
          child: Container(
            padding: EdgeInsets.all(safeAreaWidth * 0.04),
            alignment: Alignment.topCenter,
            height: safeAreaHeight * 0.13,
            decoration: BoxDecoration(
              color: blackColor2,
              borderRadius: BorderRadius.circular(35),
            ),
            child: mainButton(
              context,
              text: "周囲のデバイスとの通信を開始",
              onTap: () => isStart.value = true,
            ),
          ),
        ),
      ],
    );
  }
}
