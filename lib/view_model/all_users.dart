import 'dart:async';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/utility/firebase_storage_utility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_users.g.dart';

@Riverpod(keepAlive: true)
class AllUsersNotifier extends _$AllUsersNotifier {
  @override
  Future<List<UserType>> build() async {
    return [];
  }

  Future<void> addData(String id) async {
    try {
      if (!state.value!.any((userData) => userData.id == id)) {
        final userData = await dbStorageToUserData(id: id);
        if (userData != null) {
          state = const AsyncValue.loading();
          state = await AsyncValue.guard(() async {
            return [...state.value!, userData];
          });
        }
      }
    } catch (e) {
      return;
    }
  }
}
