import 'package:bubu_v2/bespoke_profile_swiper/on_profile_swiper.dart';
import 'package:bubu_v2/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final CarouselSliderController carouselSliderController =
    CarouselSliderController();
final ScrollController scrollController = ScrollController();

class ProfileSwiperPage extends HookConsumerWidget {
  const ProfileSwiperPage({
    super.key,
    required this.allUsers,
    required this.targetIndex,
  });

  final List<UserType> allUsers;
  final int targetIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroTag = useState<String>(allUsers[targetIndex].id);
    final isAnimating = useState<bool>(true);
    final scrollBack = useState<double>(0);

    useEffect(
      () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          isAnimating.value = false;
        });
        void listener() {
          if (scrollController.offset < -60) {
            if (scrollBack.value > scrollController.offset) {
              scrollBack.value = scrollController.offset;
            } else {
              Navigator.pop(context);
              scrollController.removeListener(listener);
            }
          }
        }

        scrollController.addListener(listener);
        return () {
          scrollController.removeListener(listener);
        };
      },
      [],
    );
    return Hero(
      tag: heroTag.value,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CarouselSlider.builder(
              controller: carouselSliderController,
              initialPage: targetIndex + 1,
              onSlideChanged: (value) async {
                if (isNotScreen(value, allUsers)) {
                  Navigator.pop(context);
                }
                heroTag.value = toHeroTag(value, allUsers);
              },
              onSlideEnd:
                  context.mounted ? () => isAnimating.value = false : null,
              onSlideStart:
                  context.mounted ? () => isAnimating.value = true : null,
              slideTransform: const CubeTransform(),
              itemCount: allUsers.length + 2,
              slideBuilder: (index) {
                if (isNotScreen(index, allUsers)) {
                  return Container(
                    height: double.infinity,
                    color: Colors.black,
                  );
                } else {
                  return OnStorySwiper(
                    userData: allUsers[index - 1],
                    controller: scrollController,
                    carouselSliderController: carouselSliderController,
                    isAnimating: isAnimating,
                  );
                }
              },
            ),
            Visibility(
              visible: isAnimating.value,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String toHeroTag(int nowPageIndex, List<UserType> dataList) {
    if (nowPageIndex == 0) {
      return dataList[0].id;
    } else if (nowPageIndex == dataList.length + 1) {
      return dataList[dataList.length - 1].id;
    } else {
      return dataList[nowPageIndex - 1].id;
    }
  }

  bool isNotScreen(int index, List<UserType> dataList) {
    if (index == 0 || index == dataList.length + 1) {
      return true;
    } else {
      return false;
    }
  }
}
