import 'package:bubu_v2/constant/constant.dart';
import 'package:flutter/material.dart';

Widget imageLoadingWidget(BuildContext context) {
  final safeAreaHeight = safeHeight(context);
  return Container(
    alignment: Alignment.center,
    height: double.infinity,
    child: SizedBox(
      height: safeAreaHeight * 0.07,
      width: safeAreaHeight * 0.07,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.white,
        color: Colors.black,
      ),
    ),
  );
}
