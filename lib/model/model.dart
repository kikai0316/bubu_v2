class UserType {
  String id;
  String? profileImg;
  String name;
  String? comment;
  DateTime birthday;
  UserType({
    required this.id,
    required this.profileImg,
    required this.name,
    required this.comment,
    required this.birthday,
  });
}

class BottomMenuItemType {
  String text;
  void Function() onTap;
  BottomMenuItemType({
    required this.text,
    required this.onTap,
  });
}
