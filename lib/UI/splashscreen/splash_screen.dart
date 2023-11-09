import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/login/login_screen.dart';
import 'package:mahasainik_app/UI/main_page/main_page.dart';
import 'package:mahasainik_app/utils/image_assets.dart';
import 'package:mahasainik_app/utils/preferences_constants.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedUtils sharedUtils = SharedUtils();

  @override
  void initState() {
    super.initState();
    sharedUtils.fetchLoginStatus();
    sharedUtils.fetchUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: AppImages.mahasainikLogoWBG,
      nextScreen:
          sharedUtils.userLoginStatus! ? const MainPage() : const LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
