import 'dart:io';

import 'package:bubu_v2/component/text.dart';
import 'package:bubu_v2/constant/message.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/utility/crop_img_utility.dart';
import 'package:bubu_v2/utility/notistack_utility.dart';
import 'package:bubu_v2/utility/permission_handler_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showBottomMenu(
  BuildContext context, {
  required List<BottomMenuItemType> itemList,
}) async {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  await showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: List.generate(
        itemList.length,
        (i) => ColoredBox(
          color: Colors.white,
          child: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(
                context,
              );
              itemList[i].onTap();
            },
            child: nText(
              itemList[i].text,
              color: Colors.blue,
              fontSize: safeAreaWidth / 27,
            ),
          ),
        ),
      ),
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(
          context,
        ),
        child: nText(
          "キャンセル",
          color: Colors.red,
          fontSize: safeAreaWidth / 25,
        ),
      ),
    ),
  );
}

Future<File?> getMobileImage(
  BuildContext context,
  ValueNotifier<bool> isLoading,
) async {
  void errorShowDialog(bool isPermission) {
    isLoading.value = false;
    showAlertDialog(
      context,
      subTitle: !isPermission ? eMessageNotPhotoPermission : eMessagePhoto,
      buttonRightText: !isPermission ? "設定画面へ" : null,
      onTap: !isPermission ? () => openAppSettings() : null,
    );
  }

  isLoading.value = true;
  final isPermission = await checkPhotoPermission();
  if (!isPermission && context.mounted) {
    errorShowDialog(false);
    return null;
  }
  try {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      isLoading.value = false;
      return null;
    }
    final File file = File(pickedFile.path);
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "${file.absolute.path}_bubu.jpg",
      quality: 88,
    );
    if (compressedFile == null) {
      errorShowDialog(true);
      return null;
    }
    final isCrop = await cropProfileImg(File(compressedFile.path));
    isLoading.value = false;
    return isCrop;
  } catch (e) {
    errorShowDialog(true);
    return null;
  }
}

void bottomSheet(
  BuildContext context, {
  required Widget page,
  VoidCallback? onThen,
  VoidCallback? onError,
}) {
  showModalBottomSheet<Widget>(
    isScrollControlled: true,
    context: context,
    elevation: 0,
    backgroundColor: Colors.transparent,
    builder: (context) => page,
  )
      .then((value) => onThen?.call())
      .onError((error, stackTrace) => onError?.call());
}
