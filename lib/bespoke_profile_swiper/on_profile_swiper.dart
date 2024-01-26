import 'package:bubu_v2/bespoke_profile_swiper/widget/bottom_widget.dart';
import 'package:bubu_v2/bespoke_profile_swiper/widget/on_profile_widget.dart';
import 'package:bubu_v2/bespoke_profile_swiper/widget/tap_event_widget.dart';
import 'package:bubu_v2/bespoke_profile_swiper/widget/top_bar_widget.dart';
import 'package:bubu_v2/bespoke_profile_swiper/widget/user_data_widget.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnStorySwiper extends HookConsumerWidget {
  const OnStorySwiper({
    super.key,
    required this.userData,
    required this.controller,
    required this.carouselSliderController,
    required this.isAnimating,
  });

  final UserType userData;
  final ScrollController? controller;
  final CarouselSliderController carouselSliderController;
  final ValueNotifier<bool> isAnimating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController =
        useAnimationController(duration: const Duration(seconds: 10));
    final isImageLoaded = useState<bool>(false);
    useEffect(
      () => handleEffect(context, isImageLoaded.value, animationController),
      [isImageLoaded.value, isAnimating.value],
    );
    return SafeArea(
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: userData.profileImg ?? "",
                      placeholder: (context, url) =>
                          imageLoadingWidget(context),
                      errorWidget: (context, url, error) => const SizedBox(),
                      imageBuilder: (context, imageProvider) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (context.mounted) {
                            isImageLoaded.value = true;
                          }
                        });
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    tapEventWidget(
                      carouselSliderController,
                      animationController,
                    ),
                    TopBar(
                      animationController: animationController,
                    ),
                    userNameAndCommentWidget(context, userData),
                  ],
                ),
              ),
            ),
            bottomWidget(context),
          ],
        ),
      ),
    );
  }

  void Function()? handleEffect(
    BuildContext context,
    bool isImageLoaded,
    AnimationController animationController,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        if (isAnimating.value) {
          animationController.stop();
        } else {
          if (isImageLoaded) {
            animationController.forward().then((_) async {
              await carouselSliderController.nextPage(
                const Duration(milliseconds: 300),
              );
            });
          }
        }
      }
    });

    return null;
  }
}
