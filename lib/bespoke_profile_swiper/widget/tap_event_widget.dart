import 'package:bubu_v2/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

Widget tapEventWidget(
  CarouselSliderController carouselSliderController,
  AnimationController animationController,
) {
  void playStory() => animationController.forward().then(
        (_) => animationController.forward().then((_) async {
          await carouselSliderController.nextPage(
            const Duration(milliseconds: 300),
          );
        }),
      );

  void pauseStory() => animationController.stop();

  return Row(
    children: List.generate(
      2,
      (i) => Expanded(
        child: GestureDetector(
          onTap: [
            () => carouselSliderController.nextPage(
                  const Duration(milliseconds: 300),
                ),
            () => carouselSliderController.previousPage(
                  const Duration(milliseconds: 300),
                ),
          ][i],
          onTapDown: (_) => pauseStory(),
          onTapUp: (_) => playStory(),
          onLongPressUp: playStory,
          onLongPressDown: (_) => pauseStory(),
          onLongPress: pauseStory,
          child: Container(
            height: double.infinity,
            color: blackColor.withOpacity(0),
          ),
        ),
      ),
    ),
  );
}
