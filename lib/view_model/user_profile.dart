import 'dart:async';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/utility/firebase_storage_utility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_profile.g.dart';

@Riverpod(keepAlive: true)
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserType?> build() async {
    final profileData = await dbStorageToUserData(id: "sdavdadcdssasadas");
    return profileData;
  }

  Future<void> profileImgUpData(String downloadURL) async {
    state = await AsyncValue.guard(() async {
      final userProfile = state.value!;
      return UserType(
        id: userProfile.id,
        profileImg: downloadURL,
        name: userProfile.name,
        comment: userProfile.comment,
        birthday: userProfile.birthday,
      );
    });
  }
}
