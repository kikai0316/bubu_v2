import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/constant/message.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/utility/firebase_storage_utility.dart';
import 'package:bubu_v2/utility/notistack_utility.dart';
import 'package:bubu_v2/utility/utility.dart';
import 'package:bubu_v2/view_model/device_list.dart';
import 'package:bubu_v2/view_model/user_profile.dart';
import 'package:bubu_v2/widget/home_widget.dart';
import 'package:bubu_v2/widget/on_message_widget.dart';
import 'package:bubu_v2/widget/on_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMainPage extends HookConsumerWidget {
  const HomeMainPage({
    super.key,
    required this.userProfile,
    required this.deviceList,
    required this.allUsers,
    required this.isLoading,
    required this.upLoadTaskPercentage,
  });
  final UserType userProfile;
  final List<String> deviceList;
  final List<UserType> allUsers;
  final ValueNotifier<bool> isLoading;
  final ValueNotifier<int?> upLoadTaskPercentage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;
    useEffect(
      () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          isLoading.value = false;
        });
        return null;
      },
      [],
    );
    return Scaffold(
      backgroundColor: blackColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: xPadding(context, top: safeAreaHeight * 0.02),
                  child: nText(
                    "付近のユーザー：0人",
                    fontSize: safeAreaWidth / 25,
                    isGradation: true,
                    bold: 900,
                  ),
                ),
                _nearWidget(
                  context,
                  ref,
                  [userProfile, userProfile, userProfile],
                ),
                Padding(
                  padding: EdgeInsets.all(safeAreaWidth * 0.03),
                  child: line(context),
                ),
                Padding(
                  padding: EdgeInsets.all(safeAreaWidth * 0.03),
                  child: nText(
                    "トーク",
                    fontSize: safeAreaWidth / 17,
                    isGradation: true,
                  ),
                ),
                ...List.generate(
                  7,
                  (index) => onMessage(
                    context,
                    userData: userProfile,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: homeButtomButtonWidget(
              context,
              onTap: () {
                final deviceListnotifier =
                    ref.watch(deviceListNotifierProvider.notifier);
                deviceListnotifier.cancelNearbyService();
              },
              isStart: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nearWidget(
    BuildContext context,
    WidgetRef ref,
    List<UserType> nearUsers,
  ) {
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
                  ? () => _showBottomMenu(
                        context,
                        onEditProfileImg: () => onEditProfileImg(context, ref),
                        onEditUserProfile: () {},
                      )
                  : null,
              userData: i == 0 ? userProfile : nearUsers[i - 1],
            ),
          padingWidget,
        ],
      ),
    );
  }

  void _showBottomMenu(
    BuildContext context, {
    required VoidCallback onEditProfileImg,
    required VoidCallback onEditUserProfile,
  }) {
    showBottomMenu(
      context,
      itemList: List.generate(
        2,
        (i) => BottomMenuItemType(
          text: ["プロフィール画像を変更", "基本情報の編集"][i],
          onTap: [
            onEditProfileImg,
            onEditUserProfile,
          ][i],
        ),
      ),
    );
  }

  Future<void> onEditProfileImg(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final img = await getMobileImage(context, isLoading);
    if (img != null) {
      upLoadTaskPercentage.value = 0;
      final downloadURL = await dbStorageUpload(
        userData: userProfile,
        img: img,
        onStream: (value) => upLoadTaskPercentage.value = value,
      );
      if (!context.mounted) return;
      if (downloadURL != null) {
        upLoadTaskPercentage.value = 100;
        final userProfileNotifier =
            ref.read(userProfileNotifierProvider.notifier);
        await userProfileNotifier.profileImgUpData(downloadURL);
        upLoadTaskPercentage.value = null;
      } else {
        showAlertDialog(context, subTitle: eMessageUpLoad);
        upLoadTaskPercentage.value = null;
      }
    }
  }
}
