import 'package:bubu_v2/component/appbar.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/component/loading.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/view/home/home_main_page.dart';
import 'package:bubu_v2/view/home/home_start_page.dart';
import 'package:bubu_v2/view_model/all_users.dart';
import 'package:bubu_v2/view_model/device_list.dart';
import 'package:bubu_v2/view_model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitialPage extends HookConsumerWidget {
  const InitialPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final isLoading = useState<bool>(false);
    final upLoadTaskPercentage = useState<int?>(null);

    final userProfileState = ref.watch(userProfileNotifierProvider);
    final deviceListState = ref.watch(deviceListNotifierProvider);
    final allUsersState = ref.watch(allUsersNotifierProvider);

    final isDataReady = userProfileState is AsyncData<UserType?> &&
        deviceListState is AsyncData<List<String>?> &&
        allUsersState is AsyncData<List<UserType>>;
    if (!isDataReady) {
      return loadingPageWithLogo(context);
    }
    final UserType? userProfile = userProfileState.value;
    final List<String>? deviceList = deviceListState.value;
    final List<UserType> allUsers = allUsersState.value;
    if (userProfile == null) {
      return Center(
        child: nText("えらーー", fontSize: safeAreaWidth / 20),
      );
    }
    return Stack(
      children: [
        Scaffold(
          backgroundColor: blackColor,
          appBar: homeAppBar(context),
          body: deviceList == null
              ? HomeStartPage(
                  userProfile: userProfile,
                  isLoading: isLoading,
                )
              : HomeMainPage(
                  userProfile: userProfile,
                  allUsers: allUsers,
                  deviceList: deviceList,
                  isLoading: isLoading,
                  upLoadTaskPercentage: upLoadTaskPercentage,
                ),
        ),
        loadinPage(
          context,
          isLoading: isLoading.value,
        ),
        upLoadPage(context, percentage: upLoadTaskPercentage.value),
      ],
    );
  }
}
