import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPhotoPermission() async {
  await Permission.photos.request();
  final status = await Permission.photos.status;
  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    return false;
  } else {
    final result = await Permission.photos.request();
    return result.isGranted;
  }
}
