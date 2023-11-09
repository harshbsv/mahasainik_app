import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mahasainik_app/UI/home/search/search_screen.dart';
import 'package:mahasainik_app/UI/notifications/notifications_screen.dart';
import 'package:mahasainik_app/UI/profile/profile_screen.dart';
import 'package:mahasainik_app/bloc/nearby_stores/nearby_stores_bloc.dart';
import 'package:mahasainik_app/utils/color_assets.dart';
import 'package:mahasainik_app/utils/constants.dart';
import 'package:mahasainik_app/utils/image_assets.dart';

class HomeScreenAppBar extends StatefulWidget {
  const HomeScreenAppBar({super.key});

  @override
  State<HomeScreenAppBar> createState() => _HomeScreenAppBarState();
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  String? _currentAddress;
  Position? _currentPosition;
  NearbyStoresBloc nearbyStoresBloc = NearbyStoresBloc();

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    print('Current Position Home: $_currentPosition');
    nearbyStoresBloc.add(NearbyStoresLoadingEvent(
        _currentPosition!.latitude, _currentPosition!.longitude));
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Current Address Home: $_currentAddress');
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
      height: 230,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Column(
        children: [
          //Address & Notification Row
          Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.locationIcon,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _currentAddress ?? '',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  AppImages.profileIcon,
                  height: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          //Search bar
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Container(
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
                      enabled: false,
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
          ),
        ],
      ),
    );
  }
}
