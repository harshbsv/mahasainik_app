import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/image_assets.dart';

final List<String> imgList = [
  AppImages.banner,
  AppImages.banner,
  AppImages.banner,
  AppImages.banner,
];

class HomeScreenBannerContent extends StatefulWidget {
  const HomeScreenBannerContent({super.key});

  @override
  State<HomeScreenBannerContent> createState() =>
      _HomeScreenBannerContentState();
}

class _HomeScreenBannerContentState extends State<HomeScreenBannerContent> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: 1000,
            ),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  height: 200,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? AppColors.whiteColor
                            : AppColors.blackColor)
                        .withOpacity(
                      _current == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
