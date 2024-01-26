import 'package:bubu_v2/component/appbar.dart';
import 'package:bubu_v2/component/button.dart';
import 'package:bubu_v2/component/component.dart';
import 'package:bubu_v2/component/loading.dart';
import 'package:bubu_v2/component/text.dart';
import 'package:bubu_v2/constant/color.dart';
import 'package:bubu_v2/constant/constant.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:bubu_v2/view_model/user_profile.dart';
import 'package:bubu_v2/widget/on_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

TextEditingController? textController;

class CommentEditPage extends HookConsumerWidget {
  const CommentEditPage({
    super.key,
    required this.userData,
  });

  final UserType userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final isLoading = useState<bool>(false);
    final count = useState<int>((userData.comment ?? "").length);
    final bool isCommentState = count.value <= 25 && count.value != 0;
    useEffect(
      () {
        textController = TextEditingController(text: userData.comment ?? "");
        return null;
      },
      [],
    );
    return Stack(
      children: [
        Scaffold(
          backgroundColor: blackColor,
          appBar: nAppBar(
            context,
            title: "一言編集",
            customRightIcon: CustomAnimatedOpacityButton(
              onTap: isCommentState
                  ? () async {
                      isLoading.value = true;
                      final userProfileNotifier =
                          ref.read(userProfileNotifierProvider.notifier);
                      await userProfileNotifier.profileUpData(
                        comment: textController?.text ?? "",
                      );
                      if (context.mounted) {
                        isLoading.value = false;
                        primaryFocus?.unfocus();
                        Navigator.pop(context);
                      }
                    }
                  : null,
              child: Opacity(
                opacity: isCommentState ? 1 : 0.5,
                child: nText(
                  "完了",
                  fontSize: safeAreaWidth / 22,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: safeAreaHeight * 0.1),
                  child: SizedBox(
                    width: safeAreaWidth * 0.4,
                    height: safeAreaWidth * 0.3,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        onUser(
                          size: safeAreaWidth * 0.25,
                          userData: userData,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: xPadding(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: blackColor2,
                            ),
                            child: nTextFormField(
                              context,
                              textController: textController,
                              hintText: "一言を入力...",
                              fontSize: safeAreaWidth / 30,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                count.value = value.length;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: yPadding(context),
                  child: nText(
                    "${count.value}/25",
                    fontSize: safeAreaWidth / 25,
                    color: count.value < 20
                        ? greenColor
                        : count.value <= 25
                            ? Colors.yellow
                            : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        loadinPage(context, isLoading: isLoading.value),
      ],
    );
  }
}
