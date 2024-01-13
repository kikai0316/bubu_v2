import 'dart:async';
import 'package:bubu_v2/model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'all_users.g.dart';

@Riverpod(keepAlive: true)
class AllUsersNotifier extends _$AllUsersNotifier {
  @override
  Future<List<UserType>> build() async {
    return [];
  }
}
