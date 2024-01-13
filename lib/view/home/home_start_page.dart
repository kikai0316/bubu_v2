import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/view_model/device_list.dart';
import 'package:bubu_v2/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeStartPage extends HookConsumerWidget {
  const HomeStartPage({
    super.key,
    required this.isLoading,
    required this.userProfile,
  });
  final ValueNotifier<bool> isLoading;
  final UserType userProfile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackColor,
      body: Column(
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
          homeButtomButtonWidget(
            context,
            isStart: true,
            onTap: () {
              isLoading.value = true;
              final deviceListnotifier =
                  ref.watch(deviceListNotifierProvider.notifier);
              deviceListnotifier.initNearbyService(userProfile.id);
            },
          ),
        ],
      ),
    );
  }
}
