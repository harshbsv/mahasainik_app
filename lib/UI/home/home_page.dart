import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/constants.dart';
import 'package:mahasainik_app/utils/image_assets.dart';

final List<String> imgList = [
  AppImages.banner,
  AppImages.banner,
  AppImages.banner,
  AppImages.banner,
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchBarController = TextEditingController();
  int _current = 0;
  bool _isProductsEnabled = true;
  bool _isServicesEnabled = false;
  final CarouselController _controller = CarouselController();

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Main App Bar Container
              Container(
                padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
                height: 215,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  children: [
                    //Address & Notification Row
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.locationIcon,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'B-403, Some Residency,...',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            AppImages.bellIcon,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //App logo & Profile Row
                    Row(
                      children: [
                        Image.asset(
                          AppImages.mahasainikLogoWBG,
                          height: 50,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            AppImages.profileIcon,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.searchIcon,
                            height: 20,
                            color: AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          const SizedBox(
                            width: 290,
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(
                                color: AppColors.blackColor,
                              ),
                              cursorHeight: 22,
                              cursorColor: AppColors.blackColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: AppColors.greyColor,
                                  fontStyle: FontStyle.italic,
                                ),
                                hintText: AppConstants.searchBarHint,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              //Banner container
              Container(
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
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
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
              ),
              //Category container
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Shop by Category',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (_isProductsEnabled) {
                                _isProductsEnabled = false;
                              } else {
                                _isProductsEnabled = true;
                                _isServicesEnabled = false;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: _isProductsEnabled
                                ? AppColors.brownColor
                                : AppColors.whiteColor,
                            foregroundColor: _isProductsEnabled
                                ? AppColors.whiteColor
                                : AppColors.greyColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 42,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            'PRODUCTS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (_isServicesEnabled) {
                                _isServicesEnabled = false;
                              } else {
                                _isServicesEnabled = true;
                                _isProductsEnabled = false;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: _isServicesEnabled
                                ? AppColors.brownColor
                                : AppColors.whiteColor,
                            foregroundColor: _isServicesEnabled
                                ? AppColors.whiteColor
                                : AppColors.greyColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 42,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            'SERVICES',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.45,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.confectionerySnacks,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Confectionary/Snacks',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.beverages,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Beverages',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.dairy,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Dairy',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.fruitsVegetables,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Fruits & Vegetables',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.personalCare,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Personal Care',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.homeCare,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Home Care',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.health,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Health',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenHue,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Image.asset(
                                    AppImages.babyCare,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Baby Care',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Image.asset(AppImages.offerBanner1),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: const [
                    Text(
                      'Best Selling Products',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  height: 300,
                  width: width,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Image.asset(
                                    AppImages.bestSellingProduct1,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Brand Charger\nand Cable',
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '₹799',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Positioned(
                              top: 175,
                              right: 74,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Image.asset(
                                    AppImages.bestSellingProduct2,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Britannia Bread',
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: const [
                                    Text(
                                      '₹85',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '₹65',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 175,
                              right: 74,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Image.asset(
                                    AppImages.bestSellingProduct3,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Surf Excel\nEasy Wash',
                                  style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: const [
                                    Text(
                                      '1200',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '₹799',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 175,
                              right: 74,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: Image.asset(AppImages.offerBannerFull),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Best Selling Services',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                        child: Image.asset(
                                          AppImages.electronicRepair,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Appliance and Electronic Repair',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        '₹799',
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 195,
                              left: 100,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                        child: Image.asset(
                                          AppImages.electronicRepair,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Pest Control',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        '₹799',
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 195,
                              left: 100,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                        child: Image.asset(
                                          AppImages.electronicRepair,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Full Home Deep Cleaning',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        '₹799',
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 195,
                              left: 100,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                        child: Image.asset(
                                          AppImages.electronicRepair,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Plumber',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        '₹799',
                                        style: TextStyle(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 195,
                              left: 100,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset(AppImages.offerBanner2),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Text(
                          'Top Brands',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands1,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands2,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands3,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands4,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands5,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands6,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands7,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImages.topBrands8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Image.asset(AppImages.paytmBanner),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Shop Baby Care',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      width: width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.babyCare1,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Brand Charger\nand Cable',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '₹799',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.babyCare2,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Britannia Bread',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹85',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.babyCare3,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Surf Excel\nEasy Wash',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '1200',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹799',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Shop Fresh Fruits',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      width: width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.fruits1,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Kinnow Oranges, 1 Kg',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '₹80',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.fruits3,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Bananas, 12 count',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹46',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.fruits2,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Apples, pack of 4',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹85',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  height: 100,
                  width: width,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(AppImages.coupon1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(AppImages.coupon1),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Home Cleaning Services',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenHue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: Image.asset(AppImages.homeCleaningServices3),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text(
                                'Intense Kitchen Cleaning',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '₹799',
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenHue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: Image.asset(AppImages.homeCleaningServices2),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text(
                                'Classic Bathroom Cleaning',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Flexible(
                                child: Text(
                                  '₹799 per Bathroom',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenHue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: Image.asset(AppImages.homeCleaningServices1),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text(
                                'Sofa Deep Cleaning',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Flexible(
                                child: Text(
                                  '₹799 per Two seater Sofa',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(AppImages.offerBanner3),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Shop Daily Essentials',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      width: width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.essentials1,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Kinnow Oranges, 1 Kg',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '₹80',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.essentials2,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Bananas, 12 count',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹46',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.essentials3,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Apples, pack of 4',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹85',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Shop Skin Care',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      width: width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.skinCare1,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Kinnow Oranges, 1 Kg',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '₹80',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.skinCare2,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Bananas, 12 count',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹46',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.greyColor,
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Image.asset(
                                        AppImages.skinCare3,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    const Text(
                                      'Fresh Apples, pack of 4',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: const [
                                        Text(
                                          '₹85',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '₹65',
                                          style: TextStyle(
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 175,
                                  right: 74,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Repair Services',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenHue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: Image.asset(AppImages.repairServices3),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text(
                                'Changing Light Fittings',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Flexible(
                                child: Text(
                                  '₹799 for upto 6 lights',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenHue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: Image.asset(AppImages.repairServices2),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text(
                                'Installing Switches',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Flexible(
                                child: Text(
                                  '₹200 per Switch',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenHue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                            child: Image.asset(AppImages.repairServices1),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              const Text(
                                'Replacing Hinges',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Flexible(
                                child: Text(
                                  '₹799 for upto 4 hinges',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 80,
                        child: Image.asset(
                          AppImages.mahasainikLogoSmall,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'All Copyrights Reserved',
                    style: TextStyle(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
