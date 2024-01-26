import 'package:bubu_v2/model/model.dart';

List<UserType> filterAllUsers(List<String> ids, List<UserType> users) {
  return users.where((user) => ids.contains(user.id)).toList();
}
