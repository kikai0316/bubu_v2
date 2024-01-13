import 'dart:io';

import 'package:bubu_v2/model/model.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> dbStorageUpload({
  required UserType userData,
  required File img,
  required void Function(int) onStream,
}) async {
  final storageRef = FirebaseStorage.instance.ref(
    userData.id,
  );
  try {
    await storageRef.listAll().then(
          (result) =>
              Future.forEach<Reference>(result.items, (ref) => ref.delete()),
        );
    final mountainsRef = storageRef.child(
      "${userData.name}@${userData.birthday}@${userData.comment ?? ""} ",
    );
    final uploadTask = mountainsRef.putFile(img);
    uploadTask.snapshotEvents.listen((event) {
      try {
        onStream((event.bytesTransferred / event.totalBytes * 100).toInt());
      } catch (e) {
        return;
      }
    });
    await uploadTask;
    return mountainsRef.getDownloadURL();
  } catch (e) {
    return null;
  }
}

Future<UserType?> dbStorageToUserData({required String id}) async {
  try {
    final result = await FirebaseStorage.instance.ref(id).listAll();
    if (result.items.isEmpty) return null;
    final profileImg = await result.items.first.getDownloadURL();
    final List<String> parts = result.items.first.name.split('@');
    if (parts.length != 3) return null;
    final isComment =
        parts[2].replaceAll(' ', '').replaceAll('　', '').isNotEmpty;
    return UserType(
      id: id,
      profileImg: profileImg,
      name: parts[0],
      birthday: DateTime.parse(parts[1]),
      comment: isComment ? parts[2] : null,
    );
  } catch (e) {
    return null;
  }
}
